#!/usr/bin/env python3
import subprocess
len = 500000
x = [i for i in range(len)]
y = [len-i for i in range(len)]
size = [10 for i in range(len)]
import plotly.graph_objects as go

fig = go.Figure(data=[go.Scatter(
    x=x, y=y,
    mode='markers',
    marker_size=size)
])
json_data = fig.to_json()

with open('orca.json','w') as file_handle:
    file_handle.write(json_data)

subprocess.run(['xvfb-run', '-a', 'orca', 'graph', './orca.json', '-o', 'fig.png'])

