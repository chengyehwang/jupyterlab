# Ubuntu 20.04 + Python 3.7.X + JupyterLab 2.0.X + Snakemake + Conda + Docker

Key components:
1. Programming lanurage: [Python3](http://python.org)
2. Interactive computing: [Jupyter](http://jupyter.org)
3. Task Dependency and run: [Snakemake](https://snakemake.readthedocs.io/)
3. Package management: [Conda](http://anaconda.com)
4. Deploy the environment: [Docker](http://www.docker.com)
5. VNC server: [noVNC](https://github.com/novnc/noVNC)

Steps to create jupyterlab server:
1. download git by git clone https://github.com/chengyehwang/jupyterlab
2. cd jupyterlab
3. download docker image: make pull
4. run jupyterlab: make run
5. copy the link http://xxxx:8888#?token=yyyy and open by browser

Key features:
1. working directory shared between docker and host
    * install your tools in host and process by yourself
2. jupyterlab server is running on docker and extensions are enabled
    * jupytext for git diff, show table of content, show variables for debug
3. python3 packages: pandas, plotly are ready
    * data processing (table process, show chart)
4. cython is ready for speed
    * speedup kernel function by C level
    * compile and load module when needed
5. switch between interactive and command line
    * jupyterlab for interactive "make run"
    * ipython for command line "make cmd"
6. Debugging by [jupyterlab-debugger](https://github.com/jupyterlab/debugger)
    * normal mode by kernel "Python 3"
    * debugging mode by kernel "xpython"
7. Use Jupytext in Jupyterlab
    * new notebook "Python 3" -> file Untitled.ipynb
    * File/Save Notebook As -> your-file-name.py
    * or Rename Notebook... -> your-file-name.py
    * Access (open / save) your-file-name.py by Notebook
8. Electron
    * Plotly to image [Orca](https://github.com/plotly/orca)
9. Design Pattern
    * input / output by json
    * Data source
        * Database
        * Remote files [SSHFS](https://github.com/libfuse/sshfs)
        * S3 server [minio](http://min.io)
    * Process - interactive
        * Pandas DataFrame
        * Plotly Chart
        * show table [QGrid](http://github.com/quantopian/qgrid)
    * Report
        * Excel: [openpyxl](https://openpyxl.readthedocs.io/en/stable/)
        * PPT: [python-pptx](https://python-pptx.readthedocs.io/en/latest/)
10. reduce image size
    * Based on Docker [Ubuntu](https://hub.docker.com/_/ubuntu)
    * Based on [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
    * Add extra Ubuntu packages and Conda packages by Docker command
11. easy to customize your packages
    * Create a customized docker
        * Fork git (https://github.com/chengyehwang/jupyterlab)
        * Refine Dockerfile and shell scripts *.sh
        * "make build" to build new image
    * Run time
        * wget / vim / git / make is installed
        * "make shell" to enter container
    * trade-off between package coverage and image size
        * database: sqlite, postgresql, or mongo
12. use Makefile to maintain commands
    * run process:
        * make pull: get image from docker hub
        * make run: run jupyterlab server in container
        * make cmd: run ipython demo.py in container
        * make stop: stop and kill all docker jobs
    * develop process:
        * make build: build docker image
        * make shell: run shell in container
        * make push: push image to docker hub
        * make clean: remove images
        * make image: list images
13. demo.py is provided to demo:
    * jupytext to save as .py for diff
    * pandas to handle table and show
    * plotly to show chart
    * jupyterlab-toc to show [table of contents](http://github.com/jupyterlab/jupyterlab-toc)

14. ports & service
    * 8888: jupyterlab - computing
    * 8080: snakeviz - debug
    * 6080: novnc - X11 server
    * 9000: minio - storage
[image](https://github.com/chengyehwang/jupyterlab/blob/master/jupyter_demo.png)
