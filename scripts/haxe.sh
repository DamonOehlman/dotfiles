#!/usr/bin/env bash
ELM_HOME=$(dirname $(dirname $(which node)))/lib/node_modules/haxe
hash haxe 2> /dev/null || npm install -g haxe
hash haxe && echo "haxe:   $(haxe | head -n1 | cut -f3 -d' ')"