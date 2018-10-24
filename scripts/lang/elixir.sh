#!/usr/bin/env bash
hash elixir 2> /dev/null && tool_available "elixir" "elixir -v | tail -n1 | cut -f2 -d' '"