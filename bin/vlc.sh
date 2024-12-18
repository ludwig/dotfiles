#!/bin/bash -x

# Kill any running VLC instance
pkill VLC 2>/dev/null

# Start VLC in the background
/Applications/VLC.app/Contents/MacOS/VLC "$@" >/dev/null 2>&1 &

# Disown the process to detach it from the terminal
disown

