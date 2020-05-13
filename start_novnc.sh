#!/bin/bash
source /opt/miniconda3/etc/profile.d/conda.sh
conda activate
port=1
export DISPLAY=:${port}

# novnc server
/usr/bin/openbox >& openbox.log &
x11vnc -forever -ncache 10 -listen localhost -display ${DISPLAY} -xkb -nopw -N >& vnc.log &
/opt/novnc/utils/launch.sh --vnc localhost:5901 --listen 6080 >& novnc.log &

