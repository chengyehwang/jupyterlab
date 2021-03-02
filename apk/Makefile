SHELL := /bin/bash
all:
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid build -l com.termux.api
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid build com.termux:108
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid build -l org.fdroid.fdroid
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid publish com.termux.api
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid publish com.termux
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid publish org.fdroid.fdroid
key:
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid update --create-key
boot:
	cd termux-packages/scripts ; ./generate-bootstraps.sh --architectures aarch64
	cp termux-packages/scripts/bootstrap-aarch64.zip ./termux_bootstrap/

others:
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid rewritemeta org.fdroid.fdroid
apk:
	-rm termux-app/app/build/outputs/apk/release/app-release-unsigned.apk
	source sourceme ; cd termux-app ; ./gradlew assemble
	cp termux-app/app/build/outputs/apk/release/app-release-unsigned.apk termux_bootstrap/termux.apk
	apksigner sign -ks keystore.jks termux_bootstrap/termux.apk
	cd termux_bootstrap ; git add termux.apk
	cd termux_bootstrap ; git commit -m "update"
	cd termux_bootstrap ; git push
key:
	keytool -genkey -alias cywang -keyalg RSA -keypass 123456 -storepass 123456 -keystore keystore.jks

tensor:
	./build_libtflite_r2.4_aarch64.sh
	cp tensorflow_r2.4/bazel-bin/tensorflow/lite/delegates/gpu/libtensorflowlite_gpu_delegate.so termux_bootstrap
