#!/bin/bash

#https://github.com/robb/.dotfiles/blob/master/osx/defaults.install
#https://raw.githubusercontent.com/mathiasbynens/dotfiles/master/.osx
#https://github.com/paularmstrong/dotfiles/blob/master/osx/defaults.sh

open /Applications/App\ Store.app


echo "Setting System Preferences"

#general
defaults write -g 'AppleAquaColorVariant' -int 6 #Graphite
sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true #Darkmode Toggle Keyboard Shortcut
defaults write -g 'NSQuitAlwaysKeepsWindows' -bool false
osascript -e 'tell application "System Events" to tell appearance preferences to set recent applications limit to 0'
osascript -e 'tell application "System Events" to tell appearance preferences to set recent documents limit to 0'
osascript -e 'tell application "System Events" to tell appearance preferences to set recent servers limit to 0'

#Desktop & Screen Saver

#Dock
defaults write com.apple.dock show-process-indicators -bool false

	# hacks
defaults write com.apple.Dock mineffect scale
defaults write com.apple.Dock showhidden -bool true
killall Dock

#Mission Control
#Language & Region
#Security & Privacy
#Spotlight
#Notifications
#Displays
#Energy Saver
#Keyboard
#Mouse
#Trackpad

#Printers & Scanners
# there is a way to automate using lpadmin
cupsctl WebInterface=yes
open /System/Library/PreferencePanes/PrintAndScan.prefPane
open http://127.0.0.1:631/printers
osascript -e 'tell application "Finder"' -e 'display dialog "Are you done adding Printers?" buttons {"Yes, I am Done"}' -e 'do shell script "cupsctl WebInterface=no"' -e 'end tell'

#Sound
#App Store

echo "Setting Dock Settings"
defaults write com.apple.dock persistent-apps ""
killall -KILL Dock

echo "Setting Finder Settings"
#general
defaults write com.apple.finder ShowHardDrivesOnDesktop NO
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop YES
defaults write com.apple.finder ShowRemovableMediaOnDesktop YES
#advanced
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning NO
defaults write com.apple.finder WarnOnEmptyTrash NO
defaults write com.apple.finder EmptyTrashSecurely YES
killall Finder



echo "Installing Xcode Command Line Tools"
xcode-select --install

echo "Installing homebrew!!!"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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