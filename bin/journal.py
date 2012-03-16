#!/usr/bin/env python
"""
This program is useful for navigating my ~/journal directory.
When paths don't exist, they are created.

    Useful shell aliases
        $ alias jj='cd $(journal.py prev)'
        $ alias kk='cd $(journal.py next)'

"""

import os, sys, re
import argparse
from datetime import date, timedelta
from dateutil.relativedelta import relativedelta

ROOT = os.path.join(os.getenv('HOME'), 'journal')

def log(x):
    print >>sys.stderr, x

def getcwd():
    return os.getcwd() + '/'

# -----------------------------------------------------------------------------

PAT_PREFIX  = r'^(?P<prefix>.*)'
PAT_YEAR    = r'(?P<year>\d{4})'
PAT_MONTH   = r'(?P<month>\d{2})'
PAT_DAY     = r'(?P<day>\d{2})'
PAT_REST    = r'(?P<rest>.*)$'

PAT_DPATH = '%s/%s/%s-%s/%s' % (PAT_PREFIX, PAT_YEAR, PAT_MONTH, PAT_DAY, PAT_REST)
PAT_MPATH = '%s/%s/%s/%s' % (PAT_PREFIX, PAT_YEAR, PAT_MONTH, PAT_REST)
PAT_YPATH = '%s/%s/%s' % (PAT_PREFIX, PAT_YEAR, PAT_REST)

pat = {
    'day'   : re.compile(PAT_DPATH),
    'month' : re.compile(PAT_MPATH),
    'year'  : re.compile(PAT_YPATH),
}

def match_path(p):
    if pat['day'].match(p):
        return 'day'
    if pat['month'].match(p):
        return 'month'
    if pat['year'].match(p):
        return 'year'
    return None

def build_path(year=None, month=None, day=None, offset=0):
    if day:
        d = date(year, month, day)
        d = d + relativedelta(days=offset)
        return os.path.join(ROOT, d.strftime('%Y/%m-%d'))
    if month:
        d = date(year, month, 1)
        d = d + relativedelta(months=offset)
        return os.path.join(ROOT, d.strftime('%Y/%m'))
    if year:
        d = date(year, 1, 1)
        d = d + relativedelta(years=offset)
        return os.path.join(ROOT, d.strftime('%Y'))
    d = date.today()
    d = d + timedelta(days=offset)
    return os.path.join(ROOT, d.strftime('%Y/%m-%d'))

class Path(object):

    def __init__(self, path, offset=0):
        if not path.endswith('/'):
            path += '/'
        self.path = path
        self.kind = match_path(path)
        self._reset()
        self._parse()

    def _reset(self):
        self.prefix = None
        self.year   = None
        self.month  = None
        self.day    = None
        self.rest   = None

    def _parse(self):
        if pat['day'].match(self.path):
            self._parse_day()
        elif pat['month'].match(self.path):
            self._parse_month()
        elif pat['year'].match(self.path):
            self._parse_year()
        else:
            self._reset()

    def _parse_day(self):
        m = pat['day'].match(self.path)
        if m:
            self.kind   = 'day'
            self.prefix = m.group('prefix')
            self.year   = int(m.group('year'))
            self.month  = int(m.group('month'))
            self.day    = int(m.group('day'))
            self.rest   = m.group('rest')

    def _parse_month(self):
        m = pat['month'].match(self.path)
        if m:
            self.kind   = 'month'
            self.prefix = m.group('prefix')
            self.year   = int(m.group('year'))
            self.month  = int(m.group('month'))
            self.day    = None
            self.rest   = m.group('rest')

    def _parse_year(self):
        m = pat['year'].match(self.path)
        if m:
            self.kind   = 'year'
            self.prefix = m.group('prefix')
            self.year   = int(m.group('year'))
            self.month  = None
            self.day    = None
            self.rest   = m.group('rest')

    def components(self):
        return (self.kind, self.prefix, self.year, self.month, self.day, self.rest)

    def next(self):
        p = build_path(year=self.year,
                       month=self.month,
                       day=self.day,
                       offset=1)
        q = Path(p)
        return q

    def prev(self):
        p = build_path(year=self.year,
                       month=self.month,
                       day=self.day,
                       offset=-1)
        q = Path(p)
        return q


# -----------------------------------------------------------------------------

if __name__ == '__main__':

    #log(sys.argv)

    action = None
    offset = 0
    if len(sys.argv) > 1:
        if sys.argv[1] == 'prev':
            action = 'prev'
            offset = -1
        elif sys.argv[1] == 'next':
            action = 'next'
            offset = 1
        else:
            offset = int(sys.argv[1])

    path = getcwd()
    if not match_path(path):
        today = date.today()
        path = build_path(year=today.year, month=today.month, day=today.day)

    p = Path(path)

    if action == 'next':
        p = p.next()
    elif action == 'prev':
        p = p.prev()

    if os.path.exists(p.path):
        print p.path
    else:
        log("Path %r doesn't exist!" % p.path)
        print getcwd()

