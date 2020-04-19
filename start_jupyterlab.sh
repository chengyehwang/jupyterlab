#!/bin/bash
source ~/miniconda3/etc/profile.d/conda.sh
conda activate
host=`ifconfig | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | grep 172.17.0`

jupyter-lab --ip=$host --allow-root --no-browser 2>&1 | (trap '' INT ; exec sed -u "s@http://$host:8888@http://$1:8888@g")

