#!/usr/bin/env bash

ELM_HOME="$(dirname $(dirname $(which node)))"/lib/node_modules/elm/share
ELM_TARGET_VERSION="0.18.0"

echo -ne "\n${YELLOW}altJS:\t${NC}"

# typescript
hash tsc 2> /dev/null || npm install -g typescript
hash tsc && tool_available tsc "tsc --version | cut -f2 -d' '" typescript

# flow
hash flow 2> /dev/null || npm install -g flow-bin
tool_available flow "flow version | sed s/[^0-9.]//g"

# haxe
hash haxe 2> /dev/null || yarn global add haxe
tool_available haxe "haxe -version 2>&1"

# elm
hash elm 2> /dev/null || yarn global add elm
tool_available elm "elm make -h | head -n1 | sed -E 's/(\(|\))//g' | cut -f5 -d' '"
