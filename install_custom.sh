npm config set user 0
npm config set unsafe-perm true
npm install electron@7.2.2 -g

apt-get install -y tightvncserver

mkdir -p /root/.vnc
echo "123456" | tightvncpasswd -f >  /root/.vnc/passwd
chmod 700 /root/.vnc/passwd
export USER=root
vncserver 
vncserver -kill :1
echo "xhost +" >> /root/.vnc/xstartup
apt install -y gdebi-core
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
gdebi -n google-chrome-stable_current_amd64.deb
