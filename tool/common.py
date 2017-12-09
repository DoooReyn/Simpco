# encoding=utf-8

import os

def sub_path(src, dst):
    r = fix_suffix(os.path.realpath(dst))
    return src.replace(r, '')

def project_dir():
    return fix_suffix(os.path.realpath('../../'))

def fix_suffix(fp):
    if fp[-1] != '/':
        fp += '/'
    return fp

def walk(root, func):
    for r, d, f in os.walk(root):
        for fd in f:
            fp = os.path.realpath(os.path.join(r, fd))
            func(fp)

def list2lua(s, l):
    lua = ['\t' * (l - 1) + '{\n']
    for v in s:
        if isinstance(v, dict):
            lua.extend(dict2lua(v, l+1))
        elif isinstance(v, list):
            lua.extend(list2lua(v, l + 1))
        else:
            lua.append()
    lua.append('\t' * (l - 1) + '},\n')
    return lua

def dict2lua(d, l=1):
    lua = ['\t' * (l-1) + '{\n']
    for k, v in d.iteritems():
        lua.append('\t' * l + "['%s'] = " % k)
        if isinstance(v, dict):
            lua.extend(dict2lua(v, l + 1))
        elif isinstance(v, list):
            lua.extend(list2lua(v, l + 1))
        else:
            lua.append("'%s',\n" % (v))
    lua.append('\t' * (l - 1) + '},\n')
    return lua

def dump2lua(v, fp):
    with open(fp, 'w') as f:
        lua = ['return ']
        if isinstance(v, list):
            lua.extend(list2lua(v, 1))
        elif isinstance(v, dict):
            lua.extend(dict2lua(v, 1))
        else:
            pass
        f.write(''.join(lua))

