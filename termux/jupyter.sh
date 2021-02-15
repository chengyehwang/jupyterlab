#!/usr/bin/bash
install_jupyter () {
export DEBIAN_FRONTEND=noninteractive && apt update -y
export DEBIAN_FRONTEND=noninteractive && apt upgrade -y
export DEBIAN_FRONTEND=noninteractive && apt install -y pkg-config
apt install -y openssh-server wget vim net-tools make gcc g++ iproute2 git
apt install -y libgl1-mesa-glx libfreetype6-dev libjpeg62 lzma liblzma-dev
apt install -y liblapack-dev libblas-dev libxml2-dev libxslt-dev build-essential libjpeg-dev libgfortran4 nodejs gfortran zlib1g-dev libhdf5-dev libexpat1-dev
apt install -y libsqlite3-dev curl llvm tk-dev libssl-dev xz-utils libncursesw5-dev libncurses5-dev libbz2-dev libreadline-dev make libssl-dev faad

if [  -n "$(cat /etc/issue | grep Ubuntu)" ]; then
    # fix python 3.7.6 for imageai
    if [ ! -f /usr/local/bin/python3.7 ]; then
        wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz
        tar zxf Python-3.7.6.tgz
        ( cd Python-3.7.6 ; ./configure --with-ensurepip=install)
        ( cd Python-3.7.6 ; make -j 8 )
        ( cd Python-3.7.6 ; make altinstall )
    fi

else
    apt install -y python3 python3-pip python3-numpy python3-scipy python-matplotlib
fi
if [ ! -f tensorflow-2.4.0-cp37-none-linux_aarch64.whl ]; then
    wget https://github.com/lhelontra/tensorflow-on-arm/releases/download/v2.4.0/tensorflow-2.4.0-cp37-none-linux_aarch64.whl
fi
python3.7 -m pip install --upgrade pip
python3.7 -m pip install Cython==0.29.18 numpy==1.19.3
python3.7 -m pip install wheel tensorflow-2.4.0-cp37-none-linux_aarch64.whl versioned-hdf5 scipy==1.4.1 h5py==2.10.0 numpy==1.19.3 lxml matplotlib==3.3.2 pandas ipython future cython requests xlrd jupyterlab jupytext plotly python-pptx autopep8 dash dash-bootstrap-components seaborn kaleido imageai==2.1.6 keras==2.4.3 scikit-learn jupyterlab-dash pillow==7.0.0 Cython==0.29.18 python-nonblock
#--no-binary :all: --force-reinstall
python3.7 -m pip install termux-api pimux

wget https://github.com/h5py/h5py/releases/download/2.10.0/h5py-2.10.0.tar.gz
tar xvf h5py-2.10.0.tar.gz
(cd h5py-2.10.0 ; pip3.7 install .)

}
launch_sshd() {
    if [  -n "$(cat /etc/issue | grep Ubuntu)" ]; then
        apt install -y openssh-server
        passwd
        echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
        echo "Port 8022" >> /etc/ssh/sshd_config
        echo "AddressFamily any" >> /etc/ssh/sshd_config
        echo "ListenAddress 0.0.0.0" >> /etc/ssh/sshd_config
        echo "ListenAddress ::" >> /etc/ssh/sshd_config
        /etc/init.d/ssh restart
    fi
    user=`whoami`
    echo "adb forward tcp:8022 tcp:8022"
    echo "ssh $user@localhost -p 8022"
}
launch_jupyter_wlan () {
    host=`ip addr show wlan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
    echo "jupyter-lab --ip $host --no-browser --allow-root"
    cd .. ; jupyter-lab --ip $host --no-browser --allow-root
}
launch_jupyter_local () {
    host="127.0.0.1"
    echo "adb forward tcp:8888 tcp:8888"   
    echo "jupyter-lab --ip $host --no-browser --allow-root"
    cd .. ; jupyter-lab --ip $host --no-browser --allow-root
}
install_buildapk () {
   apt install -y curl
   curl -O https://raw.githubusercontent.com/BuildAPKs/buildAPKs/master/setup.buildAPKs.bash
   bash setup.buildAPKs.bash
}
install_x11 () {
    pkg install -y x11-repo
    apt install -y vim-gtk
}
launch_buildapk() {
    echo "~/buildAPKs/build.github.bash $1"
    ~/buildAPKs/build.github.bash $1
}
launch_dash() {
    host=`ip addr show wlan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
    termux-open http://localhost:8050
    python3.7 app.py -a $host
}
install_voice() {
    wget https://github.com/Uberi/speech_recognition/archive/3.8.1.zip
    unzip 3.8.1.zip
    cd speech_recognition-3.8.1 ; python3.7 -m pip install .
    apt install -y swig libpulse-dev libasound2-dev
    python3.7 -m pip install PocketSphinx
}
install_tensor() {
    update-alternatives --install /usr/bin/python python /usr/bin/python3 10

    if [ ! -f /usr/bin/bazel ]; then
        wget https://github.com/bazelbuild/bazel/releases/download/4.0.0/bazel-4.0.0-linux-arm64
        chmod 755 bazel-4.0.0-linux-arm64
	cp bazel-4.0.0-linux-arm64 /usr/bin/bazel
    fi
    git clone https://github.com/tensorflow/tensorflow.git
    cd tensorflow ; bazel build tensorflow/tools/pip_package:build_pip_package --local_ram_resources=2048
}
launch_proot_ubuntu() {
    pkg install proot-distro
    proot-distro install ubuntu-20.04
    proot-distro login ubuntu-20.04 --termux-home
}
launch_proot_debian() {
    pkg install proot-distro
    proot-distro install debian-buster
    proot-distro login debian-buster --termux-home
}
while getopts 'wijsba:dtupv' opt; do
    case $opt in
        (w) launch_jupyter_wlan;;
        (i) install_jupyter;;
        (j) launch_jupyter_local;;
        (s) launch_sshd;;
        (b) install_buildapk;;
        (a) launch_buildapk $OPTARG;;
        (x) install_x11;;
        (d) launch_dash;;
        (t) install_tensor;;
        (u) launch_proot_ubuntu;;
        (p) launch_proot_debian;;
	(v) install_voice;;
    esac
done

