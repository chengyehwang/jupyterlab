#!/bin/bash
# https://f-droid.org/en/docs/Build_Server_Setup/
source /opt/miniforge3/etc/profile.d/conda.sh
conda activate
git clone https://gitlab.com/fdroid/fdroidserver.git
cp fdroidserver/examples/makebuildserver.config.py fdroidserver/
echo "PATH=\$PATH:$HOME/fdroidserver" >> ~/.bashrc
git clone https://gitlab.com/fdroid/fdroiddata.git
cp fdroidserver/examples/makebuildserver.config.py fdroiddata/config.py
