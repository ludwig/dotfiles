#!/usr/bin/env python
import os, sys
import yaml
from pprint import pprint

def load(filename):
    with open(filename,'r') as fp:
        return [doc for doc in yaml.load_all(fp)]

def usage():
    sys.stderr.write("Usage: {0} <file.yaml>\n".format(sys.argv[0]))
    sys.exit(1)

def main():
    args = sys.argv[1:]
    argc = len(args)

    if argc == 1:
        filename = args[0]
    else:
        usage()

    for f in args:
        docs = load(f)
        print("# {0}".format(f))
        for doc in docs:
            pprint(doc)
    print("...")

if __name__ == '__main__':
    main()

# EOF
