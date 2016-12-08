#!/usr/bin/env bash
mkdir -p ~/.atom
ln -sf ${DOTFILES_HOME}/config/atom/*.cson ~/.atom/
ln -sf ${DOTFILES_HOME}/config/atom/*.less ~/.atom/
