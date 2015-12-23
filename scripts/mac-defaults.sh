#!/usr/bin/env bash
DOMAIN_GLOBAL="NSGlobalDomain"
DOMAIN_TOTALSPACES="com.binaryage.TotalSpaces2"

# my preferred interface style
defaults write $DOMAIN_GLOBAL AppleInterfaceStyle -string "Dark"
defaults write $DOMAIN_GLOBAL _HIHideMenuBar -bool true

# tap to click (see: https://github.com/mathiasbynens/dotfiles/blob/master/.osx#L153)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write $DOMAIN_GLOBAL com.apple.mouse.tapBehavior -int 1
defaults write $DOMAIN_GLOBAL com.apple.mouse.tapBehavior -int 1

# total spaces configuration
defaults write $DOMAIN_TOTALSPACES transitionSpeed -float 110