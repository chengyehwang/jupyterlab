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
