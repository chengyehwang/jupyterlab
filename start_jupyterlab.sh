#!/bin/bash
source /opt/miniconda3/etc/profile.d/conda.sh
conda activate
host_ext=$1
host=`ifconfig | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | grep 172.17.0`
#export USER=root
port=1
export DISPLAY=:${port}

# novnc server
/usr/bin/Xvfb ${DISPLAY} -screen 0 1920x1080x24 -noreset >& xvfb.log &
sleep 1
/usr/bin/openbox >& openbox.log &
x11vnc -forever -ncache 10 -listen localhost -display ${DISPLAY} -xkb -nopw -N >& vnc.log &
mkdir -p ~/.jupyter/lab
cp -rf /jupyterlab/user-settings ~/.jupyter/lab/

jupyter serverextension enable --py jupyterlab_code_formatter

jupyter-lab --ip=$host --allow-root --no-browser 2>&1 | (trap '' INT ; exec sed -u "s@\(\s*\)http://$host:8888\(.*\)@\1http://$host_ext:8888\2\n\1or http://$host:8888\2\n@g")

