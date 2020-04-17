FROM ubuntu:19.10
MAINTAINER ChengYehWang

# env for installation
RUN apt update 
RUN apt install wget python -y
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

# jupyterlab
COPY install_conda_package.sh /root/install_conda_package.sh
RUN chmod 755 /root/install_conda_package.sh
RUN source ~/miniconda3/etc/profile.d/conda.sh && conda activate && /root/install_conda_package.sh

#

COPY install_others.sh /root/install_others.sh
RUN chmod 755 /root/install_others.sh
RUN source ~/miniconda3/etc/profile.d/conda.sh && conda activate && /root/install_others.sh


# new item here
RUN apt install net-tools


