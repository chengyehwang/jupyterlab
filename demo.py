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

# # Pandas Table

import pandas as pd

data = pd.DataFrame({'a':[1,2,3],'b':[3,4,5]})
data

# # Chart by Plotly

import plotly.express as px

px.scatter(data, x='a', y='b')


