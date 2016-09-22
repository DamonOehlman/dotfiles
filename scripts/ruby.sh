#!/usr/bin/env bash
[[ -e ~/.rvm/scripts/rvm ]] && . ~/.rvm/scripts/rvm
hash rvm && rvm use ${RUBY_VERSION-2.3.0} &> /dev/null
hash ruby && tool_available "ruby" "ruby --version | cut -d' ' -f2"

# some common ruby tools
hash termrc 2> /dev/null || gem install termrc
