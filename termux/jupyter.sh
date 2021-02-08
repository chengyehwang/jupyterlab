install_jupyter () {
apt upgrade -y
apt update -y
apt install -y science-repo
apt install -y openssh wget vim net-tools make gcc
wget https://its-pointless.github.io/setup-pointless-repo.sh
source ./setup-pointless-repo.sh
apt install -y libzmq libxml2 libxslt python build-essential libjpeg-turbo openblas libgfortran4
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
launch_jupyter () {
    host=`ifconfig | grep -oE "inet 192.[0-9.]+" | tr -d "inet "`
    echo $host
    jupyter-lab --ip $host --no-browser
}

while getopts 'ijs' opt; do
    case $opt in
        (i) install_jupyter;;
        (j) launch_jupyter;;
        (s) launch_sshd;;
    esac
done

