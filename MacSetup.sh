#!/bin/bash

#https://raw.githubusercontent.com/mathiasbynens/dotfiles/master/.osx
#https://gist.githubusercontent.com/brandonb927/3195465/raw/376c300cba389908363391d8f2a23e72528dc54d/osx-for-hackers.sh
##https://github.com/zenorocha/dotfiles

# run software update
sudo softwareupdate -ia


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
# Minimize windows using: Scale effect
defaults write com.apple.Dock mineffect scale
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Show indicators for open applications - unchecked
defaults write com.apple.dock show-process-indicators -bool false
### hacks
# Use transparent icons for hidden applications
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
# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
# Sound                                                                       #
###############################################################################
# Play feedback when volume is changed
defaults write NSGlobalDomain com.apple.sound.beep.feedback -float 1
# Show volume in menu bar
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Volume.menu"
### hacks
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

#App Store
open /Applications/App\ Store.app



echo "Setting System wide"
###############################################################################
# System                                                                      #
###############################################################################
# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true



echo "Setting Finder Settings"
###############################################################################
# Finder                                                                      #
###############################################################################
### General - tab
#### Advanced - tab
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show warning before changing an extension - unchecked
defaults write com.apple.finder FXEnableExtensionChangeWarning NO
# Show warning before emptying the Trash - unchecked
defaults write com.apple.finder WarnOnEmptyTrash NO
# Empty Trash securely
defaults write com.apple.finder EmptyTrashSecurely YES
### views
# View as Columns in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
# Show Status Bar
defaults write com.apple.finder ShowStatusBar -bool true
### hacks
# allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

killall Finder



###############################################################################
# Safari                                                                      #
###############################################################################
### Advanced - tab
# Show Develop menu in menu bar
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true



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

open /opt/homebrew-cask/Caskroom/default-folder-x/*/Default\ Folder\ X\ Installer.app

mv /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app /Applications/Google\ Chrome.app
osascript -e 'tell application "Finder" to make alias file to POSIX file "/Applications/Google Chrome.app" at POSIX file "/opt/homebrew-cask/Caskroom/google-chrome/latest/"'


brew cask cleanup
sudo chflags hidden /opt/