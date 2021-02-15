"""
This app creates a simple sidebar layout using inline style arguments and the
dbc.Nav component.

dcc.Location is used to track the current location, and a callback uses the
current location to render the appropriate page content. The active prop of
each NavLink is set automatically according to the current pathname. To use
this feature you must install dash-bootstrap-components >= 0.11.0.

For more details on building multi-page Dash applications, check out the Dash
documentation: https://dash.plot.ly/urls
"""
import dash
import dash_table
import dash_bootstrap_components as dbc
import dash_core_components as dcc
import dash_html_components as html

import plotly.express as px

from dash.dependencies import Input, Output
import argparse

# application import
import pandas as pd

# camera
from pimux import function
import os
import base64

# AI
from imageai.Detection import ObjectDetection

detector = None

# JupyterLab
#end application import

app = dash.Dash(external_stylesheets=[dbc.themes.BOOTSTRAP])

# the style arguments for the sidebar. We use position:fixed and a fixed width
SIDEBAR_STYLE = {
    "position": "fixed",
    "top": 0,
    "left": 0,
    "bottom": 0,
    "width": "16rem",
    "padding": "2rem 1rem",
    "background-color": "#f8f9fa",
}

# the styles for the main content position it to the right of the sidebar and
# add some padding.
CONTENT_STYLE = {
    "margin-left": "18rem",
    "margin-right": "2rem",
    "padding": "2rem 1rem",
}

sidebar = html.Div(
    [
        html.H2("Sidebar", className="display-4"),
        html.Hr(),
        html.P(
            "A simple sidebar layout with navigation links", className="lead"
        ),
        dbc.Nav(
            [
                dbc.NavLink("Home", href="/", active="exact"),
                dbc.NavLink("CameraAI", href="/CameraAI", active="exact"),
                dbc.NavLink("MicrophoneAI", href="/MicrophoneAI", active="exact"),
                dbc.NavLink("Chart", href="/Chart", active="exact"),
                dbc.NavLink("JupyterLab", href="/JupyterLab", active="exact"),
            ],
            vertical=True,
            pills=True,
        ),
    ],
    style=SIDEBAR_STYLE,
)

content = html.Div(id="page-content", style=CONTENT_STYLE)

app.config.suppress_callback_exceptions = True

app.layout = html.Div([dcc.Location(id="url"), sidebar, content])

# MicrophoneAI APP

MicrophoneAI_layout = html.Div([
    html.Button('Record', id='MicrophoneAI-record', n_clicks=0),
    dcc.Textarea(id='MicrophoneAI-output', value='')
])
@app.callback(
    dash.dependencies.Output('MicrophoneAI-output', 'children'),
    [dash.dependencies.Input('MicrophoneAI-record', 'n_clicks')])
def trigger_microphone(n_clicks):
    import termux
    termux.Microphone.stop()
    pwd = os.environ['PWD']
    aac_file = "%s/microphone.aac"%pwd
    wave_file = "%s/microphone.wave"%pwd
    if os.path.exists(aac_file):
        os.remove(aac_file)
    termux.Microphone.record(aac_file,encoder='aac', limit=5)
    import time
    time.sleep(6)
    os.system('faad -o %s %s'%(wave_file, aac_file))
    import speech_recognition as sr
    r = sr.Recognizer()
    with sr.WavFile(wave_file) as source:
        audio = r.record(source)
    text = r.recognize_sphinx(audio)
    return text
# jupyterlab APP

JupyterLab_layout = html.Div([
    dcc.Interval(id='interval', interval=1000, n_intervals=0),
    html.Div(children='extra options for jupyterlab'),
    html.Div(dcc.Input(id='jupyterlab-options', type='text')),
    html.Button('Run', id='jupyterlab-run', n_clicks=0),
    html.Div(id='jupyterlab-status', children='Wait for command'),
    dcc.Textarea(id='jupyterlab-output', value='',
        style={'width': '100%', 'height': 800})
])
JupyterLab_process = None
JupyterLab_output = ""
@app.callback(
    dash.dependencies.Output('jupyterlab-status', 'children'),
    [dash.dependencies.Input('jupyterlab-run', 'n_clicks')],
    [dash.dependencies.State('jupyterlab-options', 'value')])
def trigger_jupyterlab_output(n_clicks, value):
    global JupyterLab_process
    global JupyterLab_output
    os.system('killall jupyter-lab')
    os.system('./jupyter.sh -j >jupyter.log 2>&1 &')
    return 'JupyterLab is running'

from nonblock import nonblock_read

@app.callback(
    dash.dependencies.Output('jupyterlab-output', 'value'),
    [dash.dependencies.Input('interval', 'n_intervals')])
def update_jupyterlab_output(n_intervals):
    global JupyterLab_process
    global JupyterLab_output
    with open('jupyter.log') as fd:
        JupyterLab_output = ''.join(fd.readlines())
    return JupyterLab_output

# End App

@app.callback(Output("page-content", "children"), [Input("url", "pathname")])
def render_page_content(pathname):
    if pathname == "/":
        return html.P("This is the content of the home page!")
    elif pathname == "/CameraAI":
        pwd = os.environ['PWD']
        camera_image = '%s/camera.jpeg'%pwd
        camera_ai_image = '%s/camera_ai.jpeg'%pwd
        function.camera().takephoto(saveas=camera_image)

        global detector
        if detector is None:
            if not os.path.exists('yolo.h5'):
                os.system('wget https://github.com/OlafenwaMoses/ImageAI/releases/download/1.0/yolo.h5')
            execution_path = os.getcwd()
            detector = ObjectDetection()
            detector.setModelTypeAsYOLOv3()
            detector.setModelPath( os.path.join(execution_path , "yolo.h5"))
            detector.loadModel()
        if detector is None:
            encoded_image = base64.b64encode(open(camera_image, 'rb').read()).decode()
        else:
            detections = detector.detectObjectsFromImage(input_image=camera_image, output_image_path=camera_ai_image, minimum_percentage_probability=30)
            encoded_image = base64.b64encode(open(camera_ai_image, 'rb').read()).decode()
        return html.Div([
        html.Img(src='data:image/jpeg;base64,%s'%encoded_image),
        html.P('page 1')
        ])
    elif pathname == "/MicrophoneAI":
        return MicrophoneAI_layout
    elif pathname == "/Chart":
        #return html.P("Oh cool, this is page 2!")
        df=pd.DataFrame([{'a':12,'b':22},{'a':22,'b':12}])
        fig=px.scatter(df, x='a', y='b')
        return html.Div([
        dash_table.DataTable(
                id='table',
                columns = [{"name":i,"id":i} for i in df.columns],
                data = df.to_dict('records'),
                ),
        dcc.Graph(figure=fig)])
    elif pathname == "/JupyterLab":
        return JupyterLab_layout

    # If the user tries to reach a different page, return a 404 message
    return dbc.Jumbotron(
        [
            html.H1("404: Not found", className="text-danger"),
            html.Hr(),
            html.P(f"The pathname {pathname} was not recognised..."),
        ]
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-a', dest='host', action='store')
    args = parser.parse_args()

    print('Browser URL: http://%s:8050/'%args.host)
    app.run_server(host='0.0.0.0', port=8050, debug=True)
