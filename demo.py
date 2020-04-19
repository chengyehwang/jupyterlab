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

# %%
# %load_ext snakeviz

# %% [markdown]
# # Pandas Table

# %%
import pandas as pd

# %%
data = pd.DataFrame({'a':[1,2,3],'b':[3,4,5]})
display(data)

# %% [markdown]
# # Chart by Plotly

# %%
import plotly.express as px

# %%
px.scatter(data, x='a', y='b')


# %% [markdown]
# # SQL access

# %%
import sqlite3
import os

# %%
os.remove('test.db')

# %%
cur = sqlite3.connect('test.db').cursor()

# %%
cur.executescript('''
CREATE TABLE EMPLOYEE(firstname varchar(50),lastname varchar(50));
INSERT INTO EMPLOYEE VALUES('Tom','Mitchell');
INSERT INTO EMPLOYEE VALUES('Jack','Ryan');
''');

# %%
cur.execute("SELECT * FROM EMPLOYEE")
out = cur.fetchall()
display(out)

# %% [markdown]
# # Cython integration

# %%
import pyximport
pyximport.install(pyimport=True, language_level=3)

# %%
import demo_cython

# %%
out = demo_cython.func(1,2)
display(out)

# %% [markdown]
# # Speed Profling

# %%
# %%snakeviz
data['a']=12

# %%
