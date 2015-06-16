#!/usr/bin/env python
"""
ugh...parsing metadata for media files is highly non-trivial... just use exiv2
"""

import sys, os
from datetime import datetime
from pipes import quote
from textwrap import dedent

def fix_time():
    pass

def main():
    if len(sys.argv) <= 1:
        sys.stderr.write('No files specified!\n')
        sys.exit(1)
    for filename in sys.argv[1:]:
        fix_mtime(filename)
    return

if __name__ == '__main__':
    main()

# EOF
