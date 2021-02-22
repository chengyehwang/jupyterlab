#!/usr/bin/bash
install() {
echo "====== install/update this package    ======"
apt install -y git
git pull
echo "====== install/update sshd package    ======"
install_sshd
echo "====== install/update jupyter package ======"
install_jupyter
echo "====== install/update voice package   ======"
install_voice
echo "====== the install is complete        ======"
}
install_jupyter () {
export DEBIAN_FRONTEND=noninteractive && apt update -y
export DEBIAN_FRONTEND=noninteractive && apt upgrade -y
export DEBIAN_FRONTEND=noninteractive && apt install -y pkg-config
apt install -y openssh-server wget vim net-tools make gcc g++ iproute2 git git-lfs
apt install -y libgl1-mesa-glx libfreetype6-dev libjpeg62 lzma liblzma-dev
apt install -y liblapack-dev libblas-dev libxml2-dev libxslt-dev build-essential libjpeg-dev libgfortran4 nodejs gfortran zlib1g-dev libhdf5-dev libexpat1-dev
apt install -y libsqlite3-dev curl llvm tk-dev libssl-dev xz-utils libncursesw5-dev libncurses5-dev libbz2-dev libreadline-dev make libssl-dev faad tesseract-ocr

if [  -n "$(cat /etc/issue | grep Ubuntu)" ]; then
    # fix python 3.7.6 for imageai
    if [ ! -f "/usr/local/bin/python3.7" ]; then
        wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz
        tar zxf Python-3.7.6.tgz
        ( cd Python-3.7.6 ; ./configure --with-ensurepip=install)
        ( cd Python-3.7.6 ; make -j 8 )
        ( cd Python-3.7.6 ; make altinstall )
    fi

else
    apt install -y python3 python3-pip python3-numpy python3-scipy python-matplotlib
fi
if [ ! -f "tensorflow-2.4.0-cp37-none-linux_aarch64.whl" ]; then
    wget https://github.com/lhelontra/tensorflow-on-arm/releases/download/v2.4.0/tensorflow-2.4.0-cp37-none-linux_aarch64.whl
fi
python3.7 -m pip install --upgrade pip
python3.7 -m pip install Cython==0.29.18 numpy==1.19.3
python3.7 -m pip install wheel tensorflow-2.4.0-cp37-none-linux_aarch64.whl versioned-hdf5 scipy==1.4.1 h5py==2.10.0 numpy==1.19.3 lxml matplotlib==3.3.2 pandas ipython future cython requests xlrd jupyterlab jupytext plotly python-pptx autopep8 dash dash-bootstrap-components seaborn kaleido imageai==2.1.6 keras==2.4.3 scikit-learn jupyterlab-dash pillow==7.0.0 Cython==0.29.18 pytesseract
#--no-binary :all: --force-reinstall
python3.7 -m pip install termux-api pimux simplejson

if [ ! -d "h5py-2.10.0" ]; then
	wget https://github.com/h5py/h5py/releases/download/2.10.0/h5py-2.10.0.tar.gz
	tar xvf h5py-2.10.0.tar.gz
fi
(cd h5py-2.10.0 ; pip3.7 install .)

}
change_jupyter_password() {
        ./change_jupyter_password.py $1
}
change_sshd_password() {
        usermod --password $(echo $1 | openssl passwd -1 -stdin) root
}
install_sshd() {
	echo "cd /data/data/com.termux/files/home/jupyterlab/termux" >> ~/.bash_profile
    if [  -n "$(cat /etc/issue | grep Ubuntu)" ]; then
        apt install -y openssh-server
        echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
        echo "Port 8022" >> /etc/ssh/sshd_config
        echo "AddressFamily any" >> /etc/ssh/sshd_config
        echo "ListenAddress 0.0.0.0" >> /etc/ssh/sshd_config
        echo "ListenAddress ::" >> /etc/ssh/sshd_config
    fi
}
launch_sshd() {
    /etc/init.d/ssh restart
    user=`whoami`
    echo "adb forward tcp:8022 tcp:8022"
    echo "ssh $user@localhost -p 8022"
}
launch_jupyter_wlan () {
    host=`ip addr show wlan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
    if [ -z $host ]; then
        host=localhost
    else
        echo "====== wifi local connect ======"
        echo "browser access URL https://$host:8888/lab"
    fi
    echo "====== usb local connect  ======"
    echo "adb forward tcp:8888 tcp:8888"
    echo "browser access URL https://localhost:8888/lab"
    echo "jupyter-lab --ip 0.0.0.0 --no-browser --allow-root"
    cd .. ; jupyter-lab --ip 0.0.0.0 --no-browser --allow-root
}
launch_jupyter_local () {
    host="127.0.0.1"
    echo "====== usb local connect  ======"
    echo "adb forward tcp:8888 tcp:8888"
    echo "browser access URL https://localhost:8888/lab"
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
install_dash() {
    script=`realpath -s $0`
    echo "user=\`whoami\`" >> ~/.bash_profile
    echo "if [[ \"\$user\" == \"root\" ]] && [ -f $script ]; then" >> ~/.bash_profile
    echo "  source $script -d" >> ~/.bash_profile
    echo "fi" >> ~/.bash_profile
}
launch_dash() {
    host=`ip addr show wlan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
    if [ -z $host ]; then
        host=localhost
    fi
    termux-open http://localhost:8050
    python3.7 app.py -a $host
}
install_voice() {
    if [ ! -d "speech_recognition-3.8.1" ]; then
        wget https://github.com/Uberi/speech_recognition/archive/3.8.1.zip
        unzip 3.8.1.zip
    fi
    cd speech_recognition-3.8.1 ; python3.7 -m pip install .
    apt install -y swig libpulse-dev libasound2-dev
    python3.7 -m pip install PocketSphinx
    python3.7 -m pip install https://github.com/alphacep/vosk-api/releases/download/0.3.15/vosk-0.3.15-cp37-cp37m-linux_aarch64.whl

}
# rebuild tensor but fail
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
install_proot_myubuntu() {
    pkg install proot-distro
    cp myubuntu.sh /data/data/com.termux/files/usr/etc/proot-distro/
    proot-distro install myubuntu
}
launch_proot_myubuntu() {
    proot-distro login myubuntu --termux-home
}
install_proot_ubuntu() {
    script=`realpath -s $0`
    echo "user=\`whoami\`" >> ~/.bash_profile
    echo "if [[ \"\$user\" != \"root\" ]] && [ -f $script ]; then" >> ~/.bash_profile
    echo "  source $script -u" >> ~/.bash_profile
    echo "fi" >> ~/.bash_profile
    pkg install proot-distro
    proot-distro install ubuntu-20.04
}
launch_proot_ubuntu() {
    proot-distro login ubuntu-20.04 --termux-home
}
zip_proot_ubuntu() {
    cd ~ && git clone https://github.com/chengyehwang/ubuntu_image.git
    tar --one-file-system --ignore-failed-read --exclude='./vendor' --exclude='./system' --exclude='./apex' --exclude='./root/.cache' --exclude='./tmp' --exclude='./data' --exclude='./dev' --exclude='./sdcard' --exclude='./storage' --exclude='./root/jupyterlab' --create --gzip --file /data/data/com.termux/files/home/ubuntu_image/my_ubuntu.tar.gz -C /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu-20.04 .
    cd ~/ubuntu_image && git add my_ubuntu.tar.gz
    cd ~/ubuntu_image && git commit
    cd ~/ubuntu_image && git push
}
while getopts 'jilP:p:Ssba:xDdtUuMmzv' opt; do
    case $opt in
        (j) launch_jupyter_wlan;;
        (i) install;;
        (l) launch_jupyter_local;;
        (P) change_jupyter_password $OPTARG;;
        (p) change_sshd_password $OPTARG;;
        (S) install_sshd;;
        (s) launch_sshd;;
        (b) install_buildapk;;
        (a) launch_buildapk $OPTARG;;
        (x) install_x11;;
        (D) install_dash;;
        (d) launch_dash;;
        (t) install_tensor;;
        (U) install_proot_ubuntu;;
        (u) launch_proot_ubuntu;;
        (M) install_proot_myubuntu;;
        (m) launch_proot_myubuntu;;
        (z) zip_proot_ubuntu;;
        (v) install_voice;;
    esac
done

