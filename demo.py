# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.9.1
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

# %%
# %load_ext snakeviz
import requests

# %% [markdown]
# # Pandas table

# %%
import pandas as pd

# %%
data = pd.DataFrame({'a': [1, 2, 3], 'b': [3, 4, 5]})
display(data)

# %%
import qgrid
widget = qgrid.show_grid(data,show_toolbar=True)
widget

# %% [markdown]
# # Chart by Plotly

# %%
import plotly.express as px

# %%
px.scatter(data, x='a', y='b')


# %%
import plotly.graph_objects as go
fig = go.Figure()
fig.add_trace(go.Scatter(
    x=data['a'],
    y=data['b']
))
fig.show()

# %% [markdown]
# # Show image

# %%
import plotly.io as pio
from IPython.display import SVG, display, Image
img_bytes = pio.to_image(fig, format="svg")
display(SVG(img_bytes))

# %%
fig.write_image('out.png')

# %% [markdown]
# # Export json for Plotly viewer

# %%
pio.write_json(fig,'demo_plotly.json')

# %% [markdown]
# # SQL access

# %%
# python database api specification v2.0

# %%
import sqlite3
import os

# %%
if os.path.exists('test.db'):
    os.remove('test.db')

# %%
cur = sqlite3.connect('test.db').cursor()

# %%
cur.executescript('''
CREATE TABLE EMPLOYEE(firstname varchar(50),lastname varchar(50));
INSERT INTO EMPLOYEE VALUES('Tom','Mitchell');
INSERT INTO EMPLOYEE VALUES('Jack','Ryan');
''')
;

# %%
cur.execute("SELECT * FROM EMPLOYEE")
out = cur.fetchall()
display(out)

# %% [markdown]
# # Cython integration

# %%
import pyximport
pyximport.install(reload_support=True, language_level=3)

# %%
import demo_cython

# %%
out = demo_cython.func(1, 2)
display(out)

# %% [markdown]
# # Speed profiling

# %%
# %%snakeviz
data['t'] = 12

# %% [markdown]
# # Widget

# %%
import ipywidgets as widgets

# %%
slider = widgets.IntSlider()
output = widgets.Output()
display(slider, output)


def on_value_change(change):
    with output:
        print(change['new'])


slider.observe(on_value_change, names='value')
