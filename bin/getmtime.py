#!/usr/bin/env python
import sys, os
from datetime import datetime

def getmtime(x):
    t = os.path.getmtime(x)
    return datetime.fromtimestamp(t)

def getctime(x):
    t = os.path.getctime(x)
    return datetime.fromtimestamp(t)

def getatime(x):
    t = os.path.getatime(x)
    return datetime.fromtimestamp(t)

def main():
    args = sys.argv[1:]

    for x in args:
        mtime = getmtime(x)
        ctime = getctime(x)
        atime = getatime(x)

        print(x)
        print('    mtime: {0}'.format(mtime))
        print('    ctime: {0}'.format(ctime))
        print('    atime: {0}'.format(atime))

if __name__ == '__main__':
    main()

# EOF
