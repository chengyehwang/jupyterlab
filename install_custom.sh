npm config set user 0
npm config set unsafe-perm true
npm install electron@7.2.2 -g

apt-get install -y xvfb

apt install -y gdebi-core
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
gdebi -n google-chrome-stable_current_amd64.deb
