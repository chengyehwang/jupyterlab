##
## Plug-in for installing Ubuntu Focal.
##

DISTRO_NAME="myubuntu"

# You can override a CPU architecture to let distribution
# be executed by QEMU (user-mode).
#
# You can specify the following values here:
#
#  * aarch64: AArch64 (ARM64, 64bit ARM)
#  * armv7l:  ARM (32bit)
#  * i686:    x86 (32bit)
#  * x86_64:  x86 (64bit)
#
# Default value is set by proot-distro script and is equal
# to the CPU architecture of your device (uname -m).
#DISTRO_ARCH=$(uname -m)

# Returns download URL and SHA-256 of file in this format:
# SHA-256|FILE-NAME
get_download_url() {
	local rootfs
	local sha256

	rootfs="https://github.com/chengyehwang/ubuntu_image/blob/main/my_ubuntu.tar.gz"
	sha256="588688a4ba3c2d2f875c24706e3defb8a43eb522bfc9c00a2541c82f09321c77"

	echo "${sha256}|${rootfs}"
}

# Define here additional steps which should be executed
# for configuration.
distro_setup() {
	# Hint: $PWD is the distribution rootfs directory.
	#echo "hello world" > ./etc/motd

	# Run command within proot'ed environment with
	# run_proot_cmd function.
	# Uncomment this to do system upgrade during installation.
	#run_proot_cmd apt update
	#run_proot_cmd apt upgrade -yq
	:
}
