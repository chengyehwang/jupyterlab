install_jupyter () {
apt upgrade -y
apt update -y
apt install -y science-repo
apt install -y openssh wget vim net-tools make gcc
#wget https://its-pointless.github.io/setup-pointless-repo.sh
#source ./setup-pointless-repo.sh
apt install -y libzmq libxml2 libxslt build-essential libjpeg-turbo openblas libgfortran4 libcompiler-rt nodejs
#if [ ! -f ./python_3.8.6_aarch64.deb ]; then
#    wget https://github.com/Termux-pod/termux-pod/raw/main/arch64/python/python-3.8.6/python_3.8.6_aarch64.deb
#fi
#apt install ./python_3.8.6_aarch64.deb
#scipy
pip3 install --upgrade pip
pip3 install wheel
pip3 install numpy lxml matplotlib pandas ipython future cython requests xlrd jupyterlab jupytext plotly python-pptx autopep8 dash dash-bootstrap-components seaborn kaleido
#kivy
}
launch_sshd() {
    apt install -y openssh
    passwd
    sshd_abs=`which sshd`
    $sshd_abs
    user=`whoami`
    echo "adb forward tcp:8022 tcp:8022"
    echo "ssh $user@localhost -p 8022"
}
launch_jupyter_wlan () {
    host=`ip addr show wlan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
    echo "jupyter-lab --ip $host --no-browser --allow-root"
    jupyter-lab --ip $host --no-browser --allow-root
}
launch_jupyter_local () {
    host="localhost"
    echo "adb forward tcp:8888 tcp:8888"   
    echo "jupyter-lab --ip $host --no-browser --allow-root"
    jupyter-lab --ip $host --no-browser --allow-root
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
while getopts 'wilsba:d' opt; do
    case $opt in
        (w) launch_jupyter_wlan;;
        (i) install_jupyter;;
        (l) launch_jupyter_local;;
        (s) launch_sshd;;
        (b) install_buildapk;;
        (a) launch_buildapk $OPTARG;;
        (x) install_x11;;
        (d) launch_dash;;
    esac
done

