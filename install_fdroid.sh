export DEBIAN_FRONTEND=noninteractive && apt install -y fdroidserver disorderfs curl
fdroid init && fdroid update -c && fdroid update
pip3 install clint qrcode androguard
adduser --disabled-password fdroid
apt remove -y openjdk-11-jdk-headless openjdk-11-jre-headless
