#!/usr/bin/env bash

echo -ne "\n${YELLOW}altJS:\t${NC}"

# flow
hash flow 2> /dev/null || npm install -g flow-bin
hash flow && tool_available flow "flow version | sed s/[^0-9.]//g"

# typescript
hash tsc 2> /dev/null || npm install -g typescript@beta
hash tsc && tool_available tsc "tsc --version | cut -f2 -d' '" typescript

# haxe
hash haxe 2> /dev/null || npm install -g haxe
tool_available haxe "haxe | head -n1 | cut -f3 -d' '"

# elm
ELM_HOME=$(dirname $(dirname $(which node)))/lib/node_modules/elm/share
hash elm 2> /dev/null || npm install -g elm
tool_available elm "elm make -h | head -n1 | cut -f2 -d' '"


