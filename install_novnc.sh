conda install -y jupyter-server-proxy
jupyter serverextension enable --sys-prefix jupyter_server_proxy
jupyter labextension install @jupyterlab/server-proxy
jupyter labextension uninstall nbdime-jupyterlab

apt-get install -y ca-certificates openssl xvfb x11vnc openbox supervisor
git clone https://github.com/novnc/noVNC.git /opt/novnc
git clone https://github.com/novnc/websockify.git /opt/novnc/utils/websockify
#git clone https://github.com/chengyehwang/renku-jupyterlab-vnc
#(cd renku-jupyterlab-vnc ; rm yarn.lock)
#(cd renku-jupyterlab-vnc ; npm install ; npm run build ; jupyter labextension link .)
#(cd renku-jupyterlab-vnc ; jupyter lab build)
