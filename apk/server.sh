#!/bin/bash
# https://f-droid.org/en/docs/Build_Server_Setup/
git clone https://gitlab.com/fdroid/fdroidserver.git
echo "PATH=\$PATH:$PWD/fdroidserver" >> ~/.bashrc
git clone https://gitlab.com/fdroid/fdroiddata.git
ln -s ../keystore.p12 fdroiddata
ln -s ../config.yml fdroiddata
