# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.5.0
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

import vaex

x = vaex.from_dict({'a': [1, 2, 3], 'b': [2, 3, 4]})

x.a

x[x.a == 1]

x.columns

x

x.scatter(x.a, x.b)

x.plot_widget(x.a, x.b)

import vaex
df = vaex.example()
df.select(df.x > 0)
df.plot_widget(df.x, df.y, f='log1p', selection=[None, True])


