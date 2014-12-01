#!/bin/bash



echo "Setting System Preferences"
#general
defaults write -g 'AppleAquaColorVariant' -int 6
defaults write -g 'NSQuitAlwaysKeepsWindows' -bool false
osascript -e 'tell application "System Events" to tell appearance preferences to set recent applications limit to 0'
osascript -e 'tell application "System Events" to tell appearance preferences to set recent documents limit to 0'
osascript -e 'tell application "System Events" to tell appearance preferences to set recent servers limit to 0'


echo "Setting Finder Settings"
#general
deafults write com.apple.finder ShowHardDrivesOnDesktop NO
deafults write com.apple.finder ShowExternalHardDrivesOnDesktop YES
deafults write com.apple.finder ShowRemovableMediaOnDesktop YES
#advanced
deafults write com.apple.finder AppleShowAllExtensions YES
deafults write com.apple.finder FXEnableExtensionChangeWarning NO
deafults write com.apple.finder WarnOnEmptyTrash NO
deafults write com.apple.finder EmptyTrashSecurely YES


echo "Installing Xcode Command Line Tools"
xcode-select --install
sudo xcodebuild -license

echo "Installing homebrew!!!"
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew doctor

echo "Installing cask!!!"
brew install caskroom/cask/brew-cask
brew tap caskroom/versions


echo "Installing essential applications"
brew cask install --appdir="/Applications" bartender crashplan default-folder-x dropbox google-chrome google-drive istat-menus quicksilver skype synology-cloud-station teleport tinkertool usb-overdrive vmware-fusion

echo "Installing Web developer applications"
brew install node
brew cask install --appdir=/Applications adobe-creative-cloud charles firefox google-chrome-canary mamp sequel-pro sourcetree transmit sublime-text
npm install -g bower grunt-cli yo http-server less


mv /Applications/Google\ Chrome.app /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app.alias
mv /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app /Applications/Google\ Chrome.app
mv /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app.alias /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app

mv /Applications/Google\ Chrome\ Canary.app /opt/homebrew-cask/Caskroom/google-chrome-canary/latest/Google\ Chrome\ Canary.app.alias
mv /opt/homebrew-cask/Caskroom/google-chrome-canary/latest/Google\ Chrome\ Canary.app /Applications/Google\ Chrome\ Canary.app
mv /opt/homebrew-cask/Caskroom/google-chrome-canary/latest/Google\ Chrome\ Canary.app.alias /opt/homebrew-cask/Caskroom/google-chrome-canary/latest/Google\ Chrome\ Canary.app

echo "Installing misc. applications"
brew cask install --appdir="/Applications" airserver vlc

chflags hidden /opt/