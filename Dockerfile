FROM ubuntu:20.04
MAINTAINER ChengYehWang

# basic apt installation
RUN apt  update 
RUN export DEBIAN_FRONTEND=noninteractive && apt-get upgrade -y
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y x11-apps psmisc sudo sshfs wget python net-tools vim git make gcc apt-utils libnss3 iproute2 libgtk2.0-0 libgconf-2-4 libnotify-dev
RUN mkdir -p /opt
RUN cd /opt

# install trace_processor
#RUN wget http://get.perfetto.dev/trace_processor
#RUN chmod 755 trace_processor
#RUN ./trace_processor --help

# install conda
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
RUN chmod 755 ./Miniforge3-Linux-x86_64.sh
RUN ./Miniforge3-Linux-x86_64.sh -b -f -p /opt/miniforge3

SHELL ["/bin/bash", "-c", "-l"]

# conda major packages, including jupyterlab
COPY install_conda_package.sh /root/install_conda_package.sh
RUN chmod 755 /root/install_conda_package.sh
RUN source /opt/miniforge3/etc/profile.d/conda.sh && conda activate && /root/install_conda_package.sh

# pip, jupyterlab extension or others
COPY install_ext.sh /root/install_ext.sh
RUN chmod 755 /root/install_ext.sh
RUN source /opt/miniforge3/etc/profile.d/conda.sh && conda activate && /root/install_ext.sh

# for customization
COPY install_custom.sh /root/install_custom.sh
RUN chmod 755 /root/install_custom.sh
RUN source /opt/miniforge3/etc/profile.d/conda.sh && conda activate && /root/install_custom.sh

# quickly build and test
COPY install_try.sh /root/install_try.sh
RUN chmod 755 /root/install_try.sh
RUN source /opt/miniforge3/etc/profile.d/conda.sh && conda activate && /root/install_try.sh

# new
COPY install_new.sh /root/install_new.sh
RUN chmod 755 /root/install_new.sh
RUN source /opt/miniforge3/etc/profile.d/conda.sh && conda activate && /root/install_new.sh

# test
COPY install_test.sh /root/install_test.sh
RUN chmod 755 /root/install_test.sh
RUN source /opt/miniforge3/etc/profile.d/conda.sh && conda activate && /root/install_test.sh

RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y python3-pip vim-gtk3
RUN pip3 install websockify

# clean to reduce image size
RUN apt clean
RUN source /opt/miniforge3/etc/profile.d/conda.sh && conda activate && conda clean -afy

# Data sync for users who get image only
COPY Dockerfile /opt/Dockerfile
COPY start_jupyterlab.sh /opt/start_jupyterlab.sh
COPY README.md /opt/README.md
COPY Makefile /opt/Makefile
COPY demo.py /opt/demo.py
COPY demo_module.py /opt/demo_module.py
COPY demo_cython.pyx /opt/demo_cython.pyx

COPY jupyter_notebook_config.py /opt/miniforge3/etc/jupyter/jupyter_notebook_config.py

# User jupyter & home init

ARG USER_ID=1001
ARG GROUP_ID=1001
ARG USER=jupyterlab

RUN export PASSWD=`openssl passwd ${USER}` && \
    groupadd -g ${GROUP_ID} ${USER} && \
    useradd -l -m -u ${USER_ID} -g ${USER} -G sudo -p $PASSWD -s /bin/bash ${USER} && \
    install -d -m 0755 -o ${USER} -g ${USER} /home/${USER}

RUN echo "source /opt/miniforge3/etc/profile.d/conda.sh" >> /home/${USER}/.bashrc
RUN echo "conda activate" >> /home/${USER}/.bashrc
RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /home/${USER}/.bashrc

RUN chown -R ${USER}:${USER} /home/${USER}
RUN mkdir /tmp/.X11-unix
RUN chmod 1777 /tmp/.X11-unix

USER ${USER}
#workdir /home/jupyter
