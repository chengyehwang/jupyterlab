#!/usr/bin/python3
import re
packages = {}
select = {'python3':1, 'kivy':1, 'android':1, 'urllib3':1, 'chardet':1, 'idna':1}
with open('orig_pip') as fp:
    for line in fp.readlines():
        m = re.search('^(\S+)\s+(\S+)\s*$',line)
        if m:
            package = m.group(1)
            packages[package] = 1
with open('new_pip') as fp:
    for line in fp.readlines():
        m = re.search('^(\S+)\s+(\S+)\s*$',line)
        if m:
            package = m.group(1)
            if package not in packages:
                packages[package] = 1
                select[package] = 1

import glob
installs = glob.glob('/home/cywang/miniconda3/lib/python3.7/site-packages/*/__init__.py')
for install in installs:
    m = re.search('/([^/]+)/[^/]+$',install)
    if m:
        package = m.group(1)
        m = re.search('conda',package)
        if m:
            continue
        if package not in packages:
            continue
            packages[package] = 1
            select[package] = 1

with open('out','w') as fp:
    fp.write('requirements = ' + ', '.join(select.keys()) + '\n')
print('requirements = ' + ', '.join(select.keys()))

