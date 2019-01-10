#!/usr/bin/env bash

# LS color configuration
# http://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors

DI="00;34"
OW="01;34"

# if we are operating in WSL, then we probably have a whole pile of
# "executable" directories, because... reasons.  Use a different prompt
if [[ "$(uname -r)" =~ Microsoft ]]; then
  OW="04;34"
fi

export LS_COLORS="ow=${OW}:di=${DI}"
