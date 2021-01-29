#!/usr/bin/env python3
import subprocess
import plotly.graph_objects as go
import tempfile
import os


if __name__ == '__main__':
    len = 500000
    x = [i for i in range(len)]
    y = [len-i for i in range(len)]
    size = [10 for i in range(len)]

    fig = go.Figure(data=[go.Scattergl(
        x=x, y=y,
        mode='markers',
        marker_size=size)
    ])
    fig.write_image('fig.png')
