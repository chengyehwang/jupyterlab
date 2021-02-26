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
	source sourceme ; cd termux-app ; ./gradlew assemble
	cp termux-app/app/build/outputs/apk/debug/app-debug.apk termux_bootstrap/termux.apk
