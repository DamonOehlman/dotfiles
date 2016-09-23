#!/usr/bin/env bash

echo -ne "\n${YELLOW}tools:\t${NC}"

hash eslint 2> /dev/null || npm install -g eslint
tool_available eslint "echo $(eslint --version) | cut -c 2-"
