SHELL := /bin/bash
all:
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid build org.fdroid.fdroid:16
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid publish org.fdroid.fdroid:16
key:
	source sourceme ; cd fdroiddata ; ../fdroidserver/fdroid update --create-key

