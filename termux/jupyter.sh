install_jupyter () {
apt upgrade
apt update
apt install openssh
apt install libzmq python
pip install jupyterlab pandas
}
install_jupyter
