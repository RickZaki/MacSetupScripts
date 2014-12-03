#!/bin/bash

#https://github.com/robb/.dotfiles/blob/master/osx/defaults.install
#https://raw.githubusercontent.com/mathiasbynens/dotfiles/master/.osx
#https://github.com/paularmstrong/dotfiles/blob/master/osx/defaults.sh

echo "Setting System Preferences"

###############################################################################
# General                                                                     #
###############################################################################
# Appearnace: Graphite
defaults write -g 'AppleAquaColorVariant' -int 6
# Close windows when quitting an app - unchecked
defaults write -g 'NSQuitAlwaysKeepsWindows' -bool true
# Recent Items: None
osascript -e 'tell application "System Events" to tell appearance preferences to set recent applications limit to 0'
osascript -e 'tell application "System Events" to tell appearance preferences to set recent documents limit to 0'
osascript -e 'tell application "System Events" to tell appearance preferences to set recent servers limit to 0'

#Desktop & Screen Saver

###############################################################################
# Dock                                                                     #
###############################################################################
#Show indicators for open applications - unchecked
defaults write com.apple.dock show-process-indicators -bool false
# hacks
defaults write com.apple.Dock mineffect scale
defaults write com.apple.Dock showhidden -bool true
# remove all those pesky icons
defaults write com.apple.dock persistent-apps -array
killall -KILL Dock

#Mission Control
#Language & Region
#Security & Privacy
#Spotlight
#Notifications
#Displays
#Energy Saver
###############################################################################
# Keyboard                                                                    #
###############################################################################
# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

#Mouse

###############################################################################
# Trackpad                                                                    #
###############################################################################
# enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1


#Printers & Scanners
# there is a way to automate using lpadmin
cupsctl WebInterface=yes
open /System/Library/PreferencePanes/PrintAndScan.prefPane
open http://127.0.0.1:631/printers
osascript -e 'tell application "Finder"' -e 'display dialog "Are you done adding Printers?" buttons {"Yes, I am Done"}' -e 'do shell script "cupsctl WebInterface=no"' -e 'end tell'

###############################################################################
# Sound                                                                       #
###############################################################################
# Play feedback when volume is changed
defaults write NSGlobalDomain com.apple.sound.beep.feedback -float 1
# Show volume in menu bar
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Volume.menu"

#App Store
open /Applications/App\ Store.app


echo "Setting Finder Settings"
###############################################################################
# Finder                                                                      #
###############################################################################
### general - tab
defaults write com.apple.finder ShowHardDrivesOnDesktop NO
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop YES
defaults write com.apple.finder ShowRemovableMediaOnDesktop YES
#### advanced - tab
# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning NO
defaults write com.apple.finder WarnOnEmptyTrash NO
defaults write com.apple.finder EmptyTrashSecurely YES
#views
defaults write com.apple.finder ShowStatusBar -bool true
killall Finder



echo "Installing Xcode Command Line Tools"
xcode-select --install

echo "Installing homebrew!!!"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

echo "Installing cask!!!"
brew install caskroom/cask/brew-cask


echo "Installing essential applications"
brew cask install --appdir="/Applications" crashplan default-folder-x dropbox google-chrome synology-cloud-station tinkertool usb-overdrive

brew cask cleanup

sudo chflags hidden /opt/