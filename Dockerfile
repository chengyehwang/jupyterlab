FROM ubuntu:20.04
MAINTAINER ChengYehWang

# basic apt installation
RUN apt update 
RUN apt-get upgrade -y
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y x11-apps psmisc sudo sshfs wget python net-tools vim git make gcc
RUN cd /root

# install trace_processor
RUN wget http://get.perfetto.dev/trace_processor
RUN chmod 755 trace_processor
RUN ./trace_processor --help

# install conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN chmod 755 ./Miniconda3-latest-Linux-x86_64.sh
RUN ./Miniconda3-latest-Linux-x86_64.sh -b -f

RUN echo "source ~/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc
RUN echo "conda activate" >> ~/.bashrc

SHELL ["/bin/bash", "-c", "-l"]

# conda major packages, including jupyterlab
COPY install_conda_package.sh /root/install_conda_package.sh
RUN chmod 755 /root/install_conda_package.sh
RUN source ~/miniconda3/etc/profile.d/conda.sh && conda activate && /root/install_conda_package.sh

# pip, jupyterlab extension or others
COPY install_others.sh /root/install_others.sh
RUN chmod 755 /root/install_others.sh
RUN source ~/miniconda3/etc/profile.d/conda.sh && conda activate && /root/install_others.sh

# novnc
COPY install_novnc.sh /root/install_novnc.sh
RUN chmod 755 /root/install_novnc.sh
RUN  source ~/miniconda3/etc/profile.d/conda.sh && conda activate && /root/install_novnc.sh


# quickly build and test
COPY install_try.sh /root/install_try.sh
RUN chmod 755 /root/install_try.sh
RUN source ~/miniconda3/etc/profile.d/conda.sh && conda activate && /root/install_try.sh

# for customization
COPY install_custom.sh /root/install_custom.sh
RUN chmod 755 /root/install_custom.sh
RUN source ~/miniconda3/etc/profile.d/conda.sh && conda activate && /root/install_custom.sh

# clean to reduce image size
RUN apt clean
RUN source ~/miniconda3/etc/profile.d/conda.sh && conda activate && conda clean -afy

# Data sync for users who get image only
COPY Dockerfile /root/Dockerfile
COPY start_jupyterlab.sh /root/start_jupyterlab.sh
COPY README.md /root/README.md
COPY Makefile /root/Makefile
COPY demo.py /root/demo.py
COPY demo_module.py /root/demo_module.py
COPY demo_cython.pyx /root/demo_cython.pyx

#RUN adduser jupyter

#USER jupyter
#workdir /home/jupyter
