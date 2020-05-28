apt-get install -y gnupg software-properties-common
wget -q http://xpra.org/gpg.asc -O- | sudo apt-key add -
add-apt-repository "deb https://xpra.org/ focal main"
apt-get update
apt-get install -y xpra xserver-xorg-video-dummy
sed -i 's/console/anybody/g' /etc/X11/Xwrapper.config
wget https://xpra.org/xorg.conf
pip install -y pip install Appium-Python-Client

