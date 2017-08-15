#!/usr/bin/env bash
[[ -e ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
hash nvm && nvm use ${NODE_VERSION-stable} > /dev/null
hash node && tool_available "node" "node --version | cut -c2-"

# alias upgrade_yarn="$(nvm which node | sed s_/bin/node__)/lib/node_modules/npm/bin/npm-cli.js install -g yarn@latest -g"
# alias npm="yarn $@"

# make sure we have yarn
hash yarn 2> /dev/null || upgrade_yarn
