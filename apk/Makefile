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

tensor_download:
	wget https://github.com/tensorflow/tensorflow/archive/v2.4.0.zip
	unzip v2.4.0.zip
tensor_tool:
	cd tensorflow-2.4.0 ; ./tensorflow/lite/tools/make/download_dependencies.sh
	cd tensorflow-2.4.0 ; wget https://github.com/bazelbuild/bazel/releases/download/4.0.0/bazel-4.0.0-linux-x86_64
	cd tensorflow-2.4.0 ; mv bazel-4.0.0-linux-x86_64 bazel
	cd tensorflow-2.4.0 ; chmod 755 bazel
tensor_build:
	cd tensorflow-2.4.0 ; ./bazel build -c opt --fat_apk_cpu=arm64-v8a --host_crosstool_top=@bazel_tools//tools/cpp:toolchain tensorflow/lite/delegates/gpu:libtensorflowlite_gpu_delegate.so  # for dynamic library

