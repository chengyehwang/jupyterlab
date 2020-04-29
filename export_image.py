#!/usr/bin/env python3
import subprocess
import plotly.graph_objects as go
import tempfile
import os
def fig_to_png(fig, out_file):
    json_data = fig.to_json()


    temp_fd, temp_name = tempfile.mkstemp(suffix=".json")
    with open(temp_fd, 'w') as f:
        f.write(json_data)
    print(temp_name)
    subprocess.run(['xvfb-run', '-a', 'orca', 'graph', temp_name, '-o', out_file])
    os.remove(temp_name)

if __name__ == '__main__':
    len = 5000
    x = [i for i in range(len)]
    y = [len-i for i in range(len)]
    size = [10 for i in range(len)]

    fig = go.Figure(data=[go.Scatter(
        x=x, y=y,
        mode='markers',
        marker_size=size)
    ])
    fig_to_png(fig,'fig.png')
