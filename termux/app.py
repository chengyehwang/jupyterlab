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

from pimux import function
import os
import base64

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
                dbc.NavLink("Chart", href="/Chart", active="exact"),
            ],
            vertical=True,
            pills=True,
        ),
    ],
    style=SIDEBAR_STYLE,
)

content = html.Div(id="page-content", style=CONTENT_STYLE)

app.layout = html.Div([dcc.Location(id="url"), sidebar, content])


@app.callback(Output("page-content", "children"), [Input("url", "pathname")])
def render_page_content(pathname):
    if pathname == "/":
        return html.P("This is the content of the home page!")
    elif pathname == "/CameraAI":
        pwd = os.environ['PWD']
        image_file = '%s/test1.jpeg'%pwd
        function.camera().takephoto(saveas=image_file)
        encoded_image = base64.b64encode(open(image_file, 'rb').read()).decode()
        return html.Div([
        html.Img(src='data:image/jpeg;base64,%s'%encoded_image),
        html.P('page 1')
        ])
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
    parser.add_argument('-a', dest='host', action='store', default='127.0.0.1')
    args = parser.parse_args()

    app.run_server(host=args.host, port=8050, debug=True)
