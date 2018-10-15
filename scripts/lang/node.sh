#!/usr/bin/env bash
if [[ -e ~/.nvm/nvm.sh ]]; then
  . ~/.nvm/nvm.sh 2> /dev/null
  nvm use default > /dev/null
  npm config delete prefix
fi

hash node && tool_available "node" "node --version | cut -c2-"

# alias upgrade_yarn="$(nvm which node | sed s_/bin/node__)/lib/node_modules/npm/bin/npm-cli.js install -g yarn@latest -g"
# alias npm="yarn $@"

# make sure we have yarn
hash yarn 2> /dev/null || npm install -g yarn
