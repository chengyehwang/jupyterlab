#!/bin/bash
source /opt/miniconda3/etc/profile.d/conda.sh
conda activate
host_ext=$1
host=`ifconfig | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | grep 172.17.0`
port=1
export SHELL=/bin/bash
#export DISPLAY=:${port}

# framebuffer only
#/usr/bin/Xvfb ${DISPLAY} -screen 0 1920x1080x24 -noreset >& xvfb.log &


# jupyterlab user setting
mkdir -p ~/.jupyter/lab
cp -rf /jupyterlab/user-settings ~/.jupyter/lab/

# minio
./start_minio.sh

export NODE_OPTIONS=--max-old-space-size=4096
xvfb-run -a jupyter-lab --ip=$host --allow-root --no-browser 2>&1 | (trap '' INT ; exec sed -u "s@\(\s*\)http://$host:8888\(.*\)@\1http://$host_ext:8888\2\n\1or http://$host:8888\2\n@g")

