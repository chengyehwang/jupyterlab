npm config set user 0
npm config set unsafe-perm true
npm install electron@7.2.2 -g

apt-get install -y tightvncserver
mkdir -p $HOME/.vnc
vncpasswd -f <<< 123456 > $HOME/.vnc/passwd
chmod 700 $HOME/.vnc/passwd

