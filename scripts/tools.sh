#!/usr/bin/env bash
echo -e "\n== tools =="

hash eslint 2> /dev/null || npm install -g eslint

# report the eslint version (and hack around the node stdout streaming)
hash eslint && echo "eslint: $(echo $(eslint --version) | cut -c 2-)"
