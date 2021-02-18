#!/bin/bash
# https://f-droid.org/en/docs/Build_Server_Setup/
git clone https://gitlab.com/fdroid/fdroidserver.git
cp fdroidserver/examples/makebuildserver.config.py fdroidserver/
echo "PATH=\$PATH:$PWD/fdroidserver" >> ~/.bashrc
git clone https://gitlab.com/fdroid/fdroiddata.git
cp fdroidserver/examples/makebuildserver.config.py fdroiddata/config.py
