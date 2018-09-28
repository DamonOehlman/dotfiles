#!/usr/bin/env bash
RVM_ENABLED="${USE_RVM:-}"
if [[ -e ~/.rvm/scripts/rvm && "${RVM_ENABLED}" ]]; then
  . ~/.rvm/scripts/rvm
fi

tool_available "ruby" "ruby --version | cut -d' ' -f2"
