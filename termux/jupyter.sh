install_jupyter () {
apt upgrade -y
apt update -y
apt install -y pkg-config
apt install -y openssh-server wget vim net-tools make gcc iproute2 git
apt install -y libgl1-mesa-glx libfreetype6-dev
apt install -y liblapack-dev libblas-dev libxml2-dev libxslt-dev python3 python3-pip build-essential libjpeg-dev libgfortran4 nodejs gfortran zlib1g-dev libhdf5-dev
apt install -y python3-numpy python3-scipy python3-matplotlib
pip3 install --upgrade pip
pip install wheel
pip install numpy lxml matplotlib pandas ipython future cython requests xlrd jupyterlab jupytext plotly python-pptx autopep8 dash dash-bootstrap-components seaborn kaleido imageai scikit-learn jupyterlab-dash
pip install termux-api
}
launch_sshd() {
    if [ ! -d /run/sshd ]; then
        apt install -y openssh-server
        mkdir -p /run/sshd
        echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
        passwd
    fi
    sshd_abs=`which sshd`
    $sshd_abs -p 8022 -E sshd.log
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
    termux-open http://$host:8050
    python app.py -a $host
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
while getopts 'wijsba:dtup' opt; do
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
    esac
done

