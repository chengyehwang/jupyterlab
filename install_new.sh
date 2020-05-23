apt-get install -y gnupg software-properties-common
wget -q http://xpra.org/gpg.asc -O- | sudo apt-key add -
add-apt-repository "deb https://xpra.org/ focal main"
apt-get update
apt-get install -y xserver-xorg-video-dummy
sed -i 's/console/anybody/g' /etc/X11/Xwrapper.config

apt-get install -y libx11-dev libxtst-dev libxcomposite-dev \
    libxdamage-dev libxkbfile-dev xauth x11-xkb-utils xserver-xorg-video-dummy \
    python-all-dev python-gobject-dev python-gtk2-dev cython \
    libx264-dev libvpx-dev node-uglify yui-compressor
pip install xpra
