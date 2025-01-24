#!/usr/bin/env python3
"""Profile the bash startup time.

# Initial setup
To setup the profiling, modify your `~/.bash_profile` to use `BASH_XTRACEFD`

```bash
# Enable profiling
exec {BASH_XTRACEFD}>/tmp/bash-trace.log
PS4='+ $(date "+%s.%N") ${BASH_SOURCE}:${LINENO}: '
set -x

# Source .bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# ... other stuff ...

# Teardown profiling
if [[ -n "${BASH_XTRACEFD}:-" ]]; then
    set +x
    exec {BASH_XTRACEFD}>&-
    unset BASH_XTRACEFD
fi
```

# Converting the profile

Now we use this script to convert the profile into the Chrome Trace Event
format that we can load into `chrome://tracing` or into the Perfetto UI.

```bash
bash-profiler.py -i /tmp/bash-trace.log -o /tmp/bash-trace.json
```
"""

import argparse
import json
import re
from pathlib import Path


# Default input and output files
INPUT_TRACE = "/tmp/bash_profile.trace"
OUTPUT_TRACE = "/tmp/bash_profile.trace.json"

# Process ID
PID = 1


def parse_trace_line(line):
    """Parses a line of the bash trace file and extracts relevant data."""
    # Example line format: "++ 1737748168.123456789 /path/to/file:123: command"
    match = re.match(r"(\++\s)(\d+\.\d+) (.+?):(\d+): (.+)", line)
    if not match:
        return None
    nesting, timestamp, filename, lineno, command = match.groups()
    return {
        "nesting_level": len(nesting.strip()),  # Count the + signs
        "timestamp": float(timestamp),
        "file": filename,
        "lineno": int(lineno),
        "command": command.strip(),
    }


def parse_trace_lines(lines):
    """Parses the raw trace lines into a structured hierarchy with nesting levels.

    Returns a list of parsed commands, each with start time, duration, and children.
    """
    # Stack to manage nested contexts
    stack = []
    parsed_commands = []

    line_pattern = re.compile(r"(\++\s)(\d+\.\d+) (.+?):(\d+): (.+)")

    num_lines = len(lines)
    fallback_duration = 0.1  # 100ms default
    for i, line in enumerate(lines):
        match = line_pattern.match(line)
        if not match:
            continue

        nesting, timestamp, filename, lineno, command = match.groups()
        timestamp = float(timestamp)
        nesting_level = len(nesting.strip())

        # Create a new command entry
        current_command = {
            "name": command.strip(),
            "file": filename,
            "lineno": int(lineno),
            "start": timestamp,
            "duration": 0,  # Placeholder, to be calculated later
            "children": [],
        }

        # If there's a next line, calculate the duration
        if i + 1 < num_lines:
            next_match = line_pattern.match(lines[i + 1])
            if next_match:
                next_timestamp = float(next_match.group(2))
                current_command["duration"] = max(0, next_timestamp - timestamp)
        else:
            # Fallback duration for the last command
            current_command["duration"] = fallback_duration

        # Manage nesting levels
        while stack and stack[-1]["level"] >= nesting_level:
            # Close contexts until we match the current level
            stack.pop()

        if stack:
            # Add this command as a child of the current parent
            stack[-1]["command"]["children"].append(current_command)

        # Push the current command onto the stack
        stack.append({"level": nesting_level, "command": current_command})

        # Add top-level commands to the result
        if nesting_level == 1:
            parsed_commands.append(current_command)

    return parsed_commands


def generate_perfetto_events(parsed_commands, pid=PID, tid=1):
    """Recursively converts parsed commands into Perfetto trace events.

    Handles both "B"/"E" events for nesting and durations.
    """
    events = []

    def add_events(command, current_tid):
        # "Begin" event
        begin_event = {
            "name": command["name"],
            "ph": "B",  # Begin event
            "ts": int(command["start"] * 1e6),  # Convert to microseconds
            "pid": pid,
            "tid": current_tid,
            "args": {
                "filename": command["file"],
                "lineno": command["lineno"],
            },
        }
        events.append(begin_event)

        # Add children recursively, incrementing the thread ID
        for child in command["children"]:
            add_events(child, current_tid + 1)

        # "End" event
        end_event = {
            "name": command["name"],
            "ph": "E",  # End event
            "ts": int((command["start"] + command["duration"]) * 1e6),
            "pid": pid,
            "tid": current_tid,
        }
        events.append(end_event)

    # Add all top-level commands
    for cmd in parsed_commands:
        add_events(cmd, tid)

    return events


def convert_to_perfetto(input_file: Path, output_file: Path):
    """Converts bash trace to Perfetto-compatible JSON trace."""

    print(f"Converting trace: {input_file}")

    # Read the input trace file
    with open(input_file, "r") as f:
        lines = f.readlines()

    # Step 1: Parse the trace lines into a structured hierarchy
    parsed_commands = parse_trace_lines(lines)

    # Step 2: Generate Perfetto trace events from the parsed structure
    events = generate_perfetto_events(parsed_commands)

    # Wrap events in the Chrome Trace Event format
    trace_data = {
        "traceEvents": events,
    }

    # Write to output JSON file
    with open(output_file, "w") as f:
        json.dump(trace_data, f, indent=2)

    print(f"Chrome trace events written to: {output_file}")


def main():
    parser = argparse.ArgumentParser(
        description="Convert bash trace file into Chrome Trace Event format",
    )
    parser.add_argument(
        "-i",
        "--input",
        default=INPUT_TRACE,
        help="Input bash trace file",
    )
    parser.add_argument(
        "-o",
        "--output",
        default=OUTPUT_TRACE,
        help="Output JSON trace file",
    )
    args = parser.parse_args()
    input_file = Path(args.input).expanduser()
    output_file = Path(args.output).expanduser()

    if not input_file.exists():
        print(f"Error: Input file not found: {input_file}")
        return
    convert_to_perfetto(input_file, output_file)


if __name__ == "__main__":
    main()
