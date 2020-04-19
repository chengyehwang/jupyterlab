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

# %% [markdown]
# # Pandas Table

# %%
import pandas as pd

# %%
data = pd.DataFrame({'a':[1,2,3],'b':[3,4,5]})
data

# %% [markdown]
# # Chart by Plotly

# %%
import plotly.express as px

# %%
px.scatter(data, x='a', y='b')

# %% [markdown]
# # Cython

# %%
# %load_ext Cython

# %%
# %%cython

cdef int a = 0
for i in range(10):
    a += i
print(a)

# %% [markdown]
# # SQL access

# %%
# %load_ext sql

# %%
# %sql sqlite://

# %% language="sql"
# CREATE TABLE EMPLOYEE(firstname varchar(50),lastname varchar(50));  
# INSERT INTO EMPLOYEE VALUES('Tom','Mitchell');  
# INSERT INTO EMPLOYEE VALUES('Jack','Ryan');

# %%
out = %sql select * from employee
out

# %%
