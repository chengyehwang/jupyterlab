# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.4.2
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

import dask.bag as db
import dask
import time
import os

# # map

b = dask.datasets.make_people()
b.map(json.dumps).to_textfiles('data/*.json')

b = db.read_text('data/*.json')
out = b.compute()
print(len(out))

# +
sum = 0


def test(*args):
    global sum
    sum += 1


c = db.read_text('data/*.json').map(test)
# -

c.compute();

# # data flow

from dask.distributed import Client
client = Client()

# +
import math
@dask.delayed
def inc(i):
    sum = i
    for x in range(100000000):
        sum = sum * math.sin(sum)
    return sum


@dask.delayed
def add(a, b):
    sum = a + b
    for x in range(100000000):
        sum = sum * math.sin(sum)
    return sum


# -

x1 = 1
x2 = 2
x3 = inc(x1)
x4 = inc(x2)
x5 = add(x3, x4)

x5.visualize()


# %time x5.compute()

def run_job(cmd, *args):
    if (False):  # md5 pass
        pass
    else:  # really need
        print(os.popen(cmd).read())


run_job('ls')


