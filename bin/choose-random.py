#!/usr/bin/env python

import random
import sys
import os

from collections import defaultdict
from operator import itemgetter

xs = sys.argv[1:]
if not xs:
    sys.stderr.write("Can't choose from empty list!\n")
    sys.exit(1)

# run trials
trials = 100
counts = defaultdict(int)
for i in xrange(trials):
    x = random.choice(xs)
    counts[x] += 1

# sort the results
results = sorted(counts.items(), key=itemgetter(1), reverse=True)

# make the selection
print results[0][0]
