install_jupyter () {
apt upgrade
apt update
apt install -y openssh wget vi net-tools make gcc
apt install -y libzmq libxml2 libxslt python build-essential
pip install --upgrade pip
pip install numpy lxml matplotlib pandas ipython future cython requests jupyterlab plotly 
}
launch_sshd() {
    passwd
}
install_jupyter
