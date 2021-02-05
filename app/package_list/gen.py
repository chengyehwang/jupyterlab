#!/usr/bin/python3
import re
packages = {}
select = {'python3':1, 'kivy':1, 'android':1}
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
                select[package] = 1
with open('out','w') as fp:
    fp.write('requirements = ' + ', '.join(select.keys()))
print('requirements = ' + ', '.join(select.keys()))
