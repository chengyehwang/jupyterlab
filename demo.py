# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.4.2
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

# %% Collapsed="false"
# %load_ext snakeviz
import requests

# %% [markdown] Collapsed="false"
# # Pandas table

# %% Collapsed="false"
import pandas as pd

# %% Collapsed="false"
data = pd.DataFrame({'a':[1,2,3],'b':[3,4,5]})
display(data)

# %% [markdown] Collapsed="false"
# # Chart by Plotly

# %% Collapsed="false"
import plotly.express as px

# %% Collapsed="false"
px.scatter(data, x='a', y='b')


# %% Collapsed="false"
import plotly.graph_objects as go
fig = go.Figure()
fig.add_trace(go.Scatter(
    x=data['a'],
    y=data['b']
))
fig.show()

# %% [markdown] Collapsed="false"
# # Show image

# %% Collapsed="false"
import plotly.io as pio
from IPython.display import SVG, display, Image
img_bytes = pio.to_image(fig, format="svg")
display(SVG(img_bytes))

# %% Collapsed="false"
from export_image import fig_to_png
fig_to_png(fig,'out.png')
Image(filename='out.png')

# %% [markdown] Collapsed="false"
# # SQL access

# %% Collapsed="false"
# python database api specification v2.0

# %% Collapsed="false"
import sqlite3
import os

# %% Collapsed="false"
if os.path.exists('test.db'):
    os.remove('test.db')

# %% Collapsed="false"
cur = sqlite3.connect('test.db').cursor()

# %% Collapsed="false"
cur.executescript('''
CREATE TABLE EMPLOYEE(firstname varchar(50),lastname varchar(50));
INSERT INTO EMPLOYEE VALUES('Tom','Mitchell');
INSERT INTO EMPLOYEE VALUES('Jack','Ryan');
''');

# %% Collapsed="false"
cur.execute("SELECT * FROM EMPLOYEE")
out = cur.fetchall()
display(out)

# %% [markdown] Collapsed="false"
# # Cython integration

# %% Collapsed="false"
import pyximport
pyximport.install(pyimport=True, language_level=3)

# %% Collapsed="false"
import demo_cython

# %% Collapsed="false"
out = demo_cython.func(1,2)
display(out)

# %% [markdown] Collapsed="false"
# # Speed profiling

# %% Collapsed="false"
# %%snakeviz
data['t']=12

# %% Collapsed="false"
