conda install -y ptvsd openssl=1.1.1g xeus-python notebook jupyterlab_code_formatter black isort

pip install aiohttp_swagger aiopg cufflinks simpy graphviz Dumper jupyterlab-git

jupyter labextension install jupyterlab-s3-browser jupyterlab-plotly @jupyterlab/toc jupyterlab-jupytext @jupyter-widgets/jupyterlab-manager jupyter-matplotlib @lckr/jupyterlab_variableinspector @aquirdturtle/collapsible_headings jupyterlab-spreadsheet jupyterlab-drawio @jupyterlab/debugger @jupyterlab/git @axlair/jupyterlab_vim @ryantam626/jupyterlab_code_formatter

jupyter serverextension enable --py jupyterlab_code_formatter
