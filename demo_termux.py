# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.10.1
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

from pimux import function

import os
pwd = os.environ['PWD']

function.camera().takephoto(saveas='%s/test.jpeg'%pwd)

from IPython.display import Image
Image("test.jpeg")



import termux
termux.Microphone.stop()
#help(termux.API)
output = "%s/test.wave"%pwd
if os.path.exists(output):
  os.remove(output)
termux.Microphone.record(output,limit=5)



