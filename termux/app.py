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

import simplejson as json

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
    "font-size": "30px",
}

# the styles for the main content position it to the right of the sidebar and
# add some padding.
CONTENT_STYLE = {
    "margin-left": "18rem",
    "margin-right": "2rem",
    "padding": "2rem 1rem",
    "font-size": "30px",
}

sidebar = html.Div(
    [
        html.H2("Termux", className="display-4"),
        html.Hr(),
        dbc.Nav(
            [
                dbc.NavLink("Home", href="/", active="exact"),
                dbc.NavLink("CameraAI", href="/CameraAI", active="exact"),
                dbc.NavLink("MicrophoneAI", href="/MicrophoneAI", active="exact"),
                dbc.NavLink("BotAI", href="/BotAI", active="exact"),
                dbc.NavLink("Chart", href="/Chart", active="exact"),
                dbc.NavLink("JupyterLab", href="/JupyterLab", active="exact"),
                dbc.NavLink("SSHD", href="/SSHD", active="exact"),
                dbc.NavLink("Update", href="/Update", active="exact"),
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

# CameraAI APP
from pimux import function
import os
import base64

# AI
from imageai.Detection import ObjectDetection

detector = None

CameraAI_layout = html.Div([
    html.Button('Capture', id='CameraAI-capture', n_clicks=0),
    html.Img(id='CameraAI-output')
])
@app.callback(
    dash.dependencies.Output('CameraAI-output', 'src'),
    [dash.dependencies.Input('CameraAI-capture', 'n_clicks')])
def trigger_camera(n_clicks):
    if n_clicks == 0 :
        return ''
    print('trigger camera %d'%n_clicks)
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
    print('finish camera')
    return 'data:image/jpeg;base64,%s'%encoded_image

# MicrophoneAI APP

MicrophoneAI_layout = html.Div([
    html.Button('Record', id='MicrophoneAI-record', n_clicks=0),
    dcc.Textarea(id='MicrophoneAI-output', value='',
        style={'width': '100%', 'height': 300})
])
@app.callback(
    dash.dependencies.Output('MicrophoneAI-output', 'value'),
    [dash.dependencies.Input('MicrophoneAI-record', 'n_clicks')])
def trigger_microphone(n_clicks):
    if n_clicks == 0:
        return ''
    print('trigger microphone %d'%n_clicks)
    import termux
    termux.Microphone.stop()
    pwd = os.environ['PWD']
    aac_file = "%s/microphone.aac"%pwd
    wave_file = "%s/microphone.wave"%pwd
    if os.path.exists(aac_file):
        os.remove(aac_file)
    termux.Microphone.record(aac_file,encoder='aac', limit=5, count=2)
    import time
    time.sleep(6)
    os.system('faad -o %s %s'%(wave_file, aac_file))
    if False:
        import speech_recognition as sr
        r = sr.Recognizer()
        with sr.WavFile(wave_file) as source:
            audio = r.record(source)
        text = r.recognize_sphinx(audio)
    else:
        from vosk import Model, KaldiRecognizer, SetLogLevel
        import wave
        import numpy as np
        model_name = 'vosk-model-small-en-us-0.15'
        if not os.path.exists(model_name):
            os.system('wget http://alphacephei.com/vosk/models/%s.zip'%model_name)
            os.system('unzip %s.zip'%model_name)
        wf = wave.open(wave_file, "rb")
        model = Model(model_name)
        rec = KaldiRecognizer(model, wf.getframerate())
        nch   = wf.getnchannels()
        depth = wf.getsampwidth()
        typ = { 1: np.uint8, 2: np.uint16, 4: np.uint32 }.get(depth)
        sdata = wf.readframes(64000)
        data = np.frombuffer(sdata, dtype=typ)
        ch_data = data[0::nch]
        sdata = ch_data.tobytes()
        if True:
            outwav = wave.open('good.wave', 'w')
            outwav.setparams(wf.getparams())
            outwav.setnchannels(1)
            outwav.writeframes(ch_data.tobytes())
            outwav.close()

        if rec.AcceptWaveform(sdata):
            result = rec.Result()
            result = json.loads(result)
            text = result['text']
        else:
            result = rec.PartialResult()
            result = json.loads(result)
            text = result['partial']
        result = rec.FinalResult()
        result = json.loads(result)
        text += result['text']
    print('finish microphone')
    print('text:%s'%text)
    return text

# botAI APP
BotAI_layout = html.Div([
    html.Button('Capture', id='BotAI-capture', n_clicks=0),
    html.Img(id='BotAI-output')
])
@app.callback(
    dash.dependencies.Output('BotAI-output', 'src'),
    [dash.dependencies.Input('BotAI-capture', 'n_clicks')])
def trigger_botAI_output(n_clicks):
    if n_clicks == 0 :
        return ''
    print('trigger BotAI %d'%n_clicks)
    pwd = os.environ['PWD']
    camera_image = '%s/camera.jpeg'%pwd
    function.camera().takephoto(saveas=camera_image)
    import cv2
    import pytesseract
    img = cv2.imread(camera_image)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    ret, thresh1 = cv2.threshold(gray, 0, 255, cv2.THRESH_OTSU | cv2.THRESH_BINARY_INV)
    rect_kernel = cv2.getStructuringElement(cv2.MORPH_RECT,(18,18))
    dilation = cv2.dilate(thresh1, rect_kernel, iterations = 1)
    contours, hierarchy = cv2.findContours(dilation, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
    im2 = img.copy()
    for cnt in contours:
        x, y, w, h = cv2.boundingRect(cnt)
        rect = cv2.rectangle(im2, (x,y), (x+w, y+h), (0, 255, 0), 2)
        cropped = im2[y:y+h, x:x+w]
        text = pytesseract.image_to_string(cropped)
        print(x, y, w, h, text)
    
# jupyterlab APP

JupyterLab_layout = html.Div([
    dcc.Interval(id='jupyterlab-interval', interval=1000, n_intervals=0),
    html.Div(children='Password for jupyterlab'),
    html.Div(dcc.Input(id='jupyterlab-password', type='text',value='1234')),
    html.Button('Run', id='jupyterlab-run', n_clicks=0),
    html.Div(id='jupyterlab-status', children='Wait for command'),
    dcc.Textarea(id='jupyterlab-output', value='', readOnly=True,
        style={'width': '100%', 'height': 1200})
])
@app.callback(
    dash.dependencies.Output('jupyterlab-status', 'children'),
    [dash.dependencies.Input('jupyterlab-run', 'n_clicks')],
    [dash.dependencies.State('jupyterlab-password', 'value')])
def trigger_jupyterlab_output(n_clicks, value):
    if n_clicks == 0 :
        return 'Wait for command'
    print('trigger jupyterlab %d'%n_clicks)
    os.system('jupyter notebook stop 8888')
    os.system('killall jupyter-lab')
    os.system('./jupyter.sh -P %s'%value)
    os.system('./jupyter.sh -j >jupyter.log 2>&1 &')
    return 'JupyterLab is running'

from nonblock import nonblock_read

@app.callback(
    dash.dependencies.Output('jupyterlab-output', 'value'),
    [dash.dependencies.Input('jupyterlab-interval', 'n_intervals')])
def update_jupyterlab_output(n_intervals):
    JupyterLab_output = ''
    if os.path.exists('jupyter.log'):
        with open('jupyter.log') as fd:
            JupyterLab_output = ''.join(fd.readlines())
    return JupyterLab_output

# SSHD APP

SSHD_layout = html.Div([
    html.Div(children='password'),
    html.Div(dcc.Input(id='SSHD-password', type='text', value='1234')),
    html.Button('Run', id='SSHD-trigger', n_clicks=0),
    html.Div(id='SSHD-status', children='Wait for command'),
    dcc.Interval(id='SSHD-interval', interval=1000, n_intervals=0),
    dcc.Textarea(id='SSHD-output', value='', readOnly=True,
        style={'width': '100%', 'height': 1200})
])
@app.callback(
    dash.dependencies.Output('SSHD-status', 'children'),
    [dash.dependencies.Input('SSHD-trigger', 'n_clicks')],
    [dash.dependencies.State('SSHD-password', 'value')])
def trigger_SSHD(n_clicks, value):
    if n_clicks == 0 :
        return 'Wait for command'
    print('password %s'%value)
    os.system('./jupyter.sh -p %s'%value)
    print('trigger SSHD %d'%n_clicks)
    os.system('./jupyter.sh -s >sshd.log 2>&1 &')
    return 'SSHD is running'

@app.callback(
    dash.dependencies.Output('SSHD-output', 'value'),
    [dash.dependencies.Input('SSHD-interval', 'n_intervals')])
def update_SSHD_output(n_intervals):
    output = ''
    if os.path.exists('sshd.log'):
        with open('sshd.log') as fd:
            output = ''.join(fd.readlines())
    return output

# Update APP

Update_layout = html.Div([
    dcc.Interval(id='Update-interval', interval=1000, n_intervals=0),
    html.Button('Update', id='Update-trigger', n_clicks=0),
    html.Div(id='Update-status', children='Wait for command'),
    dcc.Textarea(id='Update-output', value='', readOnly=True,
        style={'width': '100%', 'height': 1200})
])
@app.callback(
    dash.dependencies.Output('Update-status', 'children'),
    [dash.dependencies.Input('Update-trigger', 'n_clicks')])
def trigger_update(n_clicks):
    if n_clicks == 0 :
        return 'Wait for command'
    print('trigger update %d'%n_clicks)
    os.system('./jupyter.sh -i >update.log 2>&1 &')
    return 'Update is running'

@app.callback(
    dash.dependencies.Output('Update-output', 'value'),
    [dash.dependencies.Input('Update-interval', 'n_intervals')])
def update_update_output(n_intervals):
    if os.path.exists('update.log'):
        with open('update.log') as fd:
            update_output = ''.join(fd.readlines())
    return update_output
# End App

@app.callback(Output("page-content", "children"), [Input("url", "pathname")])
def render_page_content(pathname):
    if pathname == "/":
        return html.P("Welcome to Termux based Python development env")
    elif pathname == "/CameraAI":
        return CameraAI_layout
    elif pathname == "/MicrophoneAI":
        return MicrophoneAI_layout
    elif pathname == "/BotAI":
        return BotAI_layout
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
    elif pathname == "/SSHD":
        return SSHD_layout
    elif pathname == "/Update":
        return Update_layout

    # If the user tries to reach a different page, return a 404 message
    return dbc.Jumbotron(
        [
            html.H1("404: Not found", className="text-danger"),
            html.Hr(),
            html.P(f"The pathname {pathname} was not recognised..."),
        ]
    )


if __name__ == "__main__":
    os.system('killall jupyter-lab')
    parser = argparse.ArgumentParser()
    parser.add_argument('-a', dest='host', action='store')
    args = parser.parse_args()

    print('Browser URL: http://%s:8050/'%args.host)
    app.run_server(host='0.0.0.0', port=8050, debug=True)
