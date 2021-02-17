#!/usr/bin/env ipython3
# -*- encoding: utf-8 -*-
import sys
import os
import fileinput
import hashlib
import random
import re
from ipython_genutils.py3compat import cast_bytes, str_to_bytes

# Get the password from the environment
password_environment_variable = sys.argv[1]

# Hash the password, this is taken from https://github.com/jupyter/notebook/blob/master/notebook/auth/security.py
salt_len = 12
algorithm = 'sha1'
h = hashlib.new(algorithm)
salt = ('%0' + str(salt_len) + 'x') % random.getrandbits(4 * salt_len)
h.update(cast_bytes(password_environment_variable, 'utf-8') + str_to_bytes(salt, 'ascii'))
password = ':'.join((algorithm, salt, h.hexdigest()))

# Store the password in the configuration
setup_line = "c.ServerApp.password = "
new_setup_line = setup_line +  "u'" + password + "'"
new_setup_line = new_setup_line.replace("# ", "")
setup_file = os.getenv("HOME") + "/.jupyter/jupyter_server_config.py"

if not os.path.exists(setup_file):
    os.system('jupyter server --generate-config')

for line in fileinput.input(setup_file, inplace=True):
    m = re.search(setup_line,line)
    if m:
        print(new_setup_line)
    else:
        print(line)
    
for line in fileinput.input(setup_file, inplace=True):
    print (line.replace("# c.ServerApp.password_required = False", "c.ServerApp.password_required = True"))
