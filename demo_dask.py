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

# # map

b = dask.datasets.make_people()
b.map(json.dumps).to_textfiles('data/*.json')

b = db.read_text('data/*.json')
out = b.compute()
print(len(out))

sum = 0
def test(*args):
    global sum
    sum +=1
c = db.read_text('data/*.json').map(test)

c.compute();


# # data flow

@dask.delayed
def inc(i):
    return i + 1
@dask.delayed
def add(a, b):
    return a + b


x1 = 1
x2 = 2
x3 = inc(x1)
x4 = inc(x2)
x5 = add(x3,x4)

x5.visualize()

x5.compute()


