SHELL := /bin/bash
all:
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid build -l com.termux.api
	#source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid build -l org.fdroid.fdroid
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid publish org.fdroid.fdroid:16
key:
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid update --create-key
others:
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid rewritemeta org.fdroid.fdroid
