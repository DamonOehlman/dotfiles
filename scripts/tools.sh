#!/usr/bin/env bash
echo -e "\n\n== tools =="

hash eslint 2> /dev/null || npm install -g eslint

# report the eslint version (and hack around the node stdout streaming)
tool_available eslint "echo $(eslint --version) | cut -c 2-"

# install budo if not available
hash budo 2> /dev/null || npm install -g budo
hash budo && tool_available budo "budo --version"
