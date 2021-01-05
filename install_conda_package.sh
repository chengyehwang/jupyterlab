for i in conda-forge anaconda mutirri temporary-recipes anaconda-platform plotly powerai
do
    conda config --add channels $i
done
conda config --set channel_priority false
conda update -n base -c defaults conda
conda install -y conda python=3.8.* numpy lxml jupyter matplotlib pandas ipython future Pillow cython graphviz pygraphviz networkx psutil requests xlrd scipy scikit-learn parse jupyterlab=3.0.* jupyterlab-dash nodejs openssl electron tesseract jupytext plotly plotly-orca libgfortran-ng yarn python-pptx autopep8 snakeviz fs.sshfs patchelf openpyxl=3.0.0 tensorflow keras imageai opencv sqlite ipython-sql postgresql psycopg2 aiohttp pgspecial aiohttp ccache seaborn jsonlines conda-build conda-verify constructor pymongo sympy ujson=1.35
