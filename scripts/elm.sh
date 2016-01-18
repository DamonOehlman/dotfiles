#!/usr/bin/env bash
ELM_HOME=$(dirname $(dirname $(which node)))/lib/node_modules/elm/share
hash elm 2> /dev/null || npm install -g elm
hash elm && echo "elm:    $(elm make -h | head -n1 | cut -f2 -d' ')"