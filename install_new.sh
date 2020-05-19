wget -q http://xpra.org/gpg.asc -O- | sudo apt-key add -
add-apt-repository "deb https://xpra.org/ xenial main"
apt-get update
apt-get install -y xpra xserver-xorg-video-dummy
wget https://xpra.org/xorg.conf
