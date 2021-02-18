export USE_SDK_WRAPPER=yes
export ANDROID_HOME=$PWD/android-sdk-linux
mkdir $ANDROID_HOME
cd $ANDROID_HOME
if [ ! -d cmdline-tools ]; then
	wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
	unzip commandlinetools-linux-6858069_latest.zip
fi
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
cmdline-tools/bin/sdkmanager --sdk_root=$PWD "platform-tools"
cmdline-tools/bin/sdkmanager --sdk_root=$PWD "tools"
cmdline-tools/bin/sdkmanager --sdk_root=$PWD "build-tools;25.0.2"
cmdline-tools/bin/sdkmanager --sdk_root=$PWD "platforms;android-24"

