#!/usr/bin/env python

import sys
import math
from PIL import Image

def get_size(length, width):
    h = int(math.ceil(float(length) / width))
    return (width, h)

def get_image(fp, width=256):
    d = fp.read()
    s = get_size(len(d), width)
    img = Image.new('L', s)
    img.putdata(d)
    return img

def main():
    if len(sys.argv) < 2:
        print("Usage: file2img.py <file> <output> [width]")
        return

    with open(sys.argv[1], 'rb') as fp:
        if len(sys.argv) > 3:
            width = int(sys.argv[3])
            img = get_image(fp, width)
        else:
            img = get_image(fp)
        img.save(sys.argv[2])

if __name__ == '__main__':
    main()

# EOF
