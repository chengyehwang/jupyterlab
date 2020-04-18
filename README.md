# Python + JupyterLab + Conda + Docker

Key components:
1. Programming lanurage: [Python3](http://python.org)
1. Interactive computing: [Jupyter](http://jupyter.org)
2. Package management: [Conda](http://anaconda.com)
3. Deploy the environment: [Docker](http://www.docker.com)


Steps to create jupyterlab server:
1. git clone https://github.com/chengyehwang/jupyterlab
2. cd jupyterlab
3. make pull
4. make run
5. open the link (url) by browser

Key features:
1. working directory shared between docker and host
    * install your tools in host and process by yourself
2. jupyterlab server is running on docker and extensions are enabled
    * jupytext for git diff, show table of content, show variables for debug
3. python3 packages: pandas, plotly are ready
    * data processing (table process, show chart)
4. cython is ready for speed
    * speedup by C level integration
5. reduce image size
    * Based on Docker [Ubuntu](https://hub.docker.com/_/ubuntu)
    * Based on [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
    * Add extra Ubuntu packages and Conda packages by Docker command
6. easy to customize your packages
    * Create a new docker
        * Fork git (https://github.com/chengyehwang/jupyterlab)
        * Refine Dockerfile and shell scripts *.sh
        * "make build" to build new image
    * Run time
        * wget / vim / git / make is ready
        * "make shell" to enter container

7. demo.py is provided to demo:
    * jupytext to handle .py
    * pandas to handle table
    * plotly to show chart
    * jupyterlab-toc to show [table of contents](http://github.com/jupyterlab/jupyterlab-toc)

![image](https://github.com/chengyehwang/jupyterlab/blob/master/jupyter_demo.png)
