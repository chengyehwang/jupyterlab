install_jupyter () {
apt upgrade -y
apt update -y
apt install -y science-repo
apt install -y openssh wget vim net-tools make gcc
wget https://its-pointless.github.io/setup-pointless-repo.sh
source ./setup-pointless-repo.sh
apt install -y libzmq libxml2 libxslt python build-essential libjpeg-turbo openblas libgfortran4 libcompiler-rt nodejs
#scipy
pip install --upgrade pip
pip install wheel
pip install numpy lxml matplotlib pandas ipython future cython requests xlrd jupyterlab jupytext plotly python-pptx autopep8 kivy dash dash-bootstrap-components
#seaborn kaleido
}
launch_sshd() {
    apt install -y openssh
    passwd
    sshd
    user=`whoami`
    echo "adb forward tcp:8022 tcp:8022"
    echo "ssh $user@localhost -p 8022"
}
launch_jupyter_wlan () {
    host=`ip addr show wlan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
    echo "jupyter-lab --ip $host --no-browser"
    jupyter-lab --ip $host --no-browser
}
launch_jupyter_local () {
    host="localhost"
    echo "adb forward tcp:8888 tcp:8888"   
    echo "jupyter-lab --ip $host --no-browser"
    jupyter-lab --ip $host --no-browser
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
    python app.py -h $host
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

