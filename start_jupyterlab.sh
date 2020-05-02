#!/bin/bash
source ~/miniconda3/etc/profile.d/conda.sh
conda activate
host_ext=$1
host=`ifconfig | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | grep 172.17.0`
export USER=root
port=1
export DISPLAY=:${port}

# novnc server
/usr/bin/Xvfb ${DISPLAY} -screen 0 1024x768x24 -noreset >& xvfb.log &
/usr/bin/openbox >& openbox.log &
x11vnc -forever -ncache 10 -display ${DISPLAY} -xkb -nopw -N >& vnc.log &
/opt/novnc/utils/launch.sh --vnc localhost:590${port} --listen 6080 >& novnc.log &

echo "novnc access http://${host_ext}:6080/vnc.html"
cp -rf user-settings ~/.jupyter/lab/
jupyter-lab --ip=$host --allow-root --no-browser 2>&1 | (trap '' INT ; exec sed -u "s@\(\s*\)http://$host:8888\(.*\)@\1http://$host_ext:8888\2\n\1or http://$host:8888\2\n@g")

