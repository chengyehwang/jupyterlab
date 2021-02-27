#!/bin/bash
# https://f-droid.org/en/docs/Build_Server_Setup/
git clone https://gitlab.com/fdroid/fdroidserver.git
echo "PATH=\$PATH:$PWD/fdroidserver" >> ~/.bashrc
git clone https://gitlab.com/fdroid/fdroiddata.git
ln -s ../keystore.p12 fdroiddata
ln -s ../config.yml fdroiddata
git clone https://github.com/termux/termux-packages.git
git clone https://github.com/chengyehwang/termux_bootstrap.git --depth 1
echo "modify termux-packages/scripts/generate-bootstraps.sh: without all"
echo "modify fdroiddata/build/com.termux/app/build.gradle"
echo "def remoteUrl = \"https://github.com/chengyehwang/termux_bootstrap/raw/main/bootstrap-\" + arch + \".zip\""

