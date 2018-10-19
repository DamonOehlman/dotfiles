#!/usr/bin/env bash
if [[ -e ~/.cargo/env ]]; then
  . ~/.cargo/env
  hash rustc && tool_available "rustc" "rustc --version | cut -f2 -d' '" "rust"
fi