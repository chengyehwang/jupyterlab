export NODE_OPTIONS=--max-old-space-size=4096
conda install -y ptvsd openssl=1.1.1g xeus-python notebook jupyterlab_code_formatter black isort

pip install aiohttp_swagger aiopg cufflinks simpy graphviz Dumper jupyterlab-git jupyterlab_iframe

jupyter labextension install jupyterlab-s3-browser jupyterlab-plotly @jupyterlab/toc jupyterlab-jupytext @jupyter-widgets/jupyterlab-manager jupyter-matplotlib @lckr/jupyterlab_variableinspector @aquirdturtle/collapsible_headings jupyterlab-spreadsheet jupyterlab-drawio @jupyterlab/debugger @jupyterlab/git @axlair/jupyterlab_vim @ryantam626/jupyterlab_code_formatter qgrid2 jupyterlab_iframe

jupyter serverextension enable --sys-prefix --py jupyterlab_iframe
jupyter serverextension enable --sys-prefix --py jupyterlab_code_formatter
