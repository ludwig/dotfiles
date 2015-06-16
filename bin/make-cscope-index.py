#!/usr/bin/env python

"""
Build cscope index
"""

import sys
import os
import errno
from os.path import expanduser
from pipes import quote

CSCOPE = '/usr/local/bin/cscope'
CSCOPE_INDEX_DIR = expanduser('~/cscope')

def usage():
    print('{0} NAME FILE1 FILE2 ...'.format(sys.argv[0]))
    sys.exit(1)

def main():

    if len(sys.argv) == 1:
        usage()

    name = os.path.join(CSCOPE_INDEX_DIR, sys.argv[1])
    files = sys.argv[2:]

    # if any files are specified, put them in 'cscope.files'
    if files:
        with open('./cscope.files', 'w') as fp:
            print("Creating 'cscope.files'")
            for f in files:
                fp.write('{0}\n'.format(os.path.abspath(f)))

    # create the index file 'cscope.out'
    print("Creating 'cscope.out'")
    cmd = '{0} -kbu'.format(CSCOPE)
    rc = os.system(cmd)

    index = os.path.abspath('./cscope.out')
    if not os.path.exists(index):
        sys.stderr.write("Could not create '{0}'\n".format(index))
        sys.exit(1)

    # symlink 'cscope.out' into CSCOPE_INDEX_DIR, with given name
    print("ln -sf {src} {dst}".format(src=quote(index), dst=quote(name)))
    try:
        os.symlink(index, name)
    except OSError, e:
        if e.errno == errno.EEXIST:
            os.remove(name)
            os.symlink(index, name)

    sys.exit(rc)


if __name__ == '__main__':
    main()
