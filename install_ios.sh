#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=$PATH:/opt/homebrew/bin
brew install autoconf automake libtool openssl pkg-config
brew tap homebrew/cask-versions
brew install --cask homebrew/cask-versions/adoptopenjdk8
brew install pkg-config sdl2 sdl2_image sdl2_ttf sdl2_mixer gstreamer

pip install kivy-ios

