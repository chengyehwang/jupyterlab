all:

build:
	cd myapp ; buildozer android debug
spec:
	wget https://raw.githubusercontent.com/kivy/buildozer/master/buildozer/default.spec -O myapp/buildozer.spec
stdio:
	wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.1.2.0/android-studio-ide-201.7042882-linux.tar.gz
	tar zxvf android-studio-ide-201.7042882-linux.tar.gz
run:
	./android-studio/bin/studio.sh
console:
	wget https://gist.githubusercontent.com/aron-bordin/8ed0d0e977e6af7a788b/raw/dd77423b3ee715bb3bcc9f58c8011ae9b4b3026a/kivyconsole.py -O console.py
