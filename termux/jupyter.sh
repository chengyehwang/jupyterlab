install_jupyter () {
apt upgrade
apt update
apt install -y openssh wget
apt install -y libzmq python
pip install --upgrade pip
pip install -y numpy lxml matplotlib pandas ipython future cython requests jupyterlab plotly 
}
install_jupyter
