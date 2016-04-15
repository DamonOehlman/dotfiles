#!/usr/bin/env bash
INTELLIJ_VERSION="2016.1"
INTELLIJ_CONFIG_HOME=~/Library/Preferences/IntelliJIdea${INTELLIJ_VERSION}/

ln -sf ${DOTFILES_HOME}/config/intellij/idea.vmoptions ${INTELLIJ_CONFIG_HOME}