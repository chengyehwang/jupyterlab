conda install -y jupyter-server-proxy
jupyter serverextension enable --sys-prefix jupyter_server_proxy
jupyter labextension install @jupyterlab/server-proxy
jupyter labextension uninstall nbdime-jupyterlab

apt-get install -y ca-certificates openssl xvfb x11vnc openbox supervisor
git clone https://github.com/novnc/noVNC.git /opt/novnc
git clone https://github.com/novnc/websockify.git /opt/novnc/utils/websockify

