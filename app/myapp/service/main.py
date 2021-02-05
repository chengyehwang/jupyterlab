#!/opt/miniforge3/bin/python

# -*- coding: utf-8 -*-
import re
import sys
import os

from notebook.notebookapp import main

if __name__ == '__main__':
    os.environ['JUPYTER_RUNTIME_DIR'] = '/data/local/tmp'
    sys.argv[0] = re.sub(r'(-script\.pyw?|\.exe)?$', '', sys.argv[0])
    sys.exit(main())
