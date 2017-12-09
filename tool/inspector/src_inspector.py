#!/usr/bin/env
# encoding=utf-8

import sys
sys.path.append('..')

import os
import common

walkdir = '../../src/app/'
subdir = '../../src/'
destFile = '../../src/source.lua'
parse_dict = {}

def parse(fp):
    base = os.path.basename(fp)
    tear = os.path.splitext(base)
    key  = tear[0]
    ext  = tear[1]
    real = fp[:-4:]
    val  = common.sub_path(real, subdir).replace('/', '.')
    parse_dict[key] = val
    common.dump2lua(parse_dict, destFile)
    
def call():
    common.walk(walkdir, parse)


if __name__ == '__main__':
    call()
