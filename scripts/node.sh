#!/usr/bin/env bash
[[ -e ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
hash nvm && nvm use ${NODE_VERSION-stable} > /dev/null
hash node && tool_available "node" "node --version | cut -c2-"
