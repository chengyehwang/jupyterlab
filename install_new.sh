apt-get install -y gnupg software-properties-common
wget -q http://xpra.org/gpg.asc -O- | sudo apt-key add -
add-apt-repository "deb https://xpra.org/ bionic main"
apt-get update
export DEBIAN_FRONTEND=noninteractive && apt-get install -y xpra xserver-xorg-video-dummy
sed -i 's/console/anybody/g' /etc/X11/Xwrapper.config
wget https://xpra.org/xorg.conf
## android test auto
pip install Appium-Python-Client imageio_ffmpeg imageio
