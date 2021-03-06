#!/usr/bin/env bash
INTELLIJ_VERSION="2017.1"
INTELLIJ_CONFIG_HOME=~/Library/Preferences/IntelliJIdea${INTELLIJ_VERSION}

if [[ -d "${INTELLIJ_CONFIG_HOME}" ]]; then
    ln -sf ${DOTFILES_HOME}/config/intellij/idea.vmoptions ${INTELLIJ_CONFIG_HOME}

    mkdir -p ${INTELLIJ_CONFIG_HOME}/keymaps
    ln -sf ${DOTFILES_HOME}/config/intellij/keymaps/djo.xml ${INTELLIJ_CONFIG_HOME}/keymaps/djo.xml

    mkdir -p ${INTELLIJ_CONFIG_HOME}/codestyles
    ln -sf ${DOTFILES_HOME}/config/intellij/codestyles/djo.xml ${INTELLIJ_CONFIG_HOME}/codestyles/djo.xml
fi