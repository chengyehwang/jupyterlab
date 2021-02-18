export DEBIAN_FRONTEND=noninteractive && apt install -y fdroidserver
fdroid init && fdroid update -c && fdroid update
pip3 install clint qrcode
adduser --disabled-password fdroid
