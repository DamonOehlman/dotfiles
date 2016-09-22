#!/usr/bin/env bash

hash flow 2> /dev/null || npm install -g flow-bin
hash flow && tool_available flow "flow version | sed s/[^0-9.]//g"
