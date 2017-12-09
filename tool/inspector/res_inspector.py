#!/usr/bin/env
# encoding=utf-8

import os
import sys
sys.path.append('..')

import common

walkdir = '../../res/'
destFile = '../../src/resource.lua'
parse_dict = {}

def parse(fp):
    base = os.path.basename(fp)
    tear = os.path.splitext(base)
    key  = tear[0]
    ext  = tear[1]
    val  = common.sub_path(fp, walkdir)
    if not parse_dict.get(ext):
        parse_dict[ext] = {}
    parse_dict[ext][key] = val

def call():
    common.walk(walkdir, parse)
    common.dump2lua(parse_dict, destFile)


if __name__ == '__main__':
    call()
