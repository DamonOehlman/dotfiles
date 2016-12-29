#!/usr/bin/env bash

echo -ne "\n${YELLOW}tools:\t${NC}"

hash eslint 2> /dev/null || npm install -g eslint
tool_available eslint "echo $(eslint --version) | cut -c 2-"

hash mert 2> /dev/null || npm install -g mert
tool_available mert "mert --version"
