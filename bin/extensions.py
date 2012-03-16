#!/usr/bin/env python

"""
Extract the file extensions from the given files,
and report how many there are of each type.
"""
import os, sys
from collections import Counter
from operator import itemgetter

count = Counter()
files = sys.argv[1:]

if len(files) > 0:

    for f in files:
        name, ext = os.path.splitext(f)
        if ext:
            ext = ext[1:]
            count[ext] += 1

    items = count.items()
    items.sort(key=itemgetter(1), reverse=True)

    for k,v in items:
        print("{0} {1}".format(k,v))

