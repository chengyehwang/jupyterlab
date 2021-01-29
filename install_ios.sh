#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=$PATH:/opt/homebrew/bin
brew install autoconf automake libtool openssl pkg-config
brew tap homebrew/cask-versions
brew install --cask homebrew/cask-versions/adoptopenjdk8

pip install python-for-android
