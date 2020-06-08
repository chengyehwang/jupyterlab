export NODE_OPTIONS=--max-old-space-size=4096
conda install -y ptvsd openssl=1.1.1g xeus-python notebook jupyterlab_code_formatter black isort jupyter-server-proxy python-language-server ipympl


pip install aiohttp_swagger aiopg cufflinks simpy graphviz Dumper jupyterlab-git jupyter-lsp

jupyter labextension install jupyterlab-s3-browser jupyterlab-plotly @jupyterlab/toc jupyterlab-jupytext @jupyter-widgets/jupyterlab-manager jupyter-matplotlib @lckr/jupyterlab_variableinspector @aquirdturtle/collapsible_headings jupyterlab-spreadsheet jupyterlab-drawio @jupyterlab/debugger @jupyterlab/git @axlair/jupyterlab_vim @ryantam626/jupyterlab_code_formatter qgrid2 @jupyterlab/server-proxy @krassowski/jupyterlab-lsp

jupyter serverextension enable --sys-prefix --py jupyterlab_code_formatter
jupyter serverextension enable --sys-prefix jupyter_server_proxy

#jupyter labextension uninstall nbdime-jupyterlab

apt-get install -y ca-certificates openssl supervisor
