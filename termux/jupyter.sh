install_jupyter () {
apt upgrade -y
apt update -y
apt install -y science-repo
apt install -y openssh wget vim net-tools make gcc
wget https://its-pointless.github.io/setup-pointless-repo.sh
source ./setup-pointless-repo.sh
apt install -y libzmq libxml2 libxslt python build-essential libjpeg-turbo openblas libgfortran4 libcompiler-rt
#scipy
pip install --upgrade pip
pip install wheel
pip install numpy lxml matplotlib pandas ipython future cython requests xlrd jupyterlab jupytext plotly python-pptx autopep8
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
while getopts 'wils' opt; do
    case $opt in
        (w) launch_jupyter_wlan;;
        (i) install_jupyter;;
        (l) launch_jupyter_local;;
        (s) launch_sshd;;
    esac
done

