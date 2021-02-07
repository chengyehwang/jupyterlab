install_jupyter () {
apt upgrade
apt update
apt install science-repo
apt install -y openssh wget vi net-tools make gcc
wget https://its-pointless.github.io/setup-pointless-repo.sh
source ./setup-pointless-repo.sh
apt install -y libzmq libxml2 libxslt python build-essential libjpeg-turbo openblas libgfortran4 scipy
pip install --upgrade pip
pip install numpy lxml matplotlib pandas ipython future cython requests xlrd jupyterlab jupytext plotly plotly-kaleido python-pptx autopep8 seaborn
}
launch_sshd() {
    passwd
}
launch_jupyter () {
    host=`ifconfig | grep -oE "inet 192.[0-9.]+" | tr -d "inet "`
    echo $host
    jupyter-lab --ip $host --no-browser
}
#install_jupyter
launch_jupyter
