#!/usr/bin/env bash
if [[ -e ~/.rvm/scripts/rvm ]]; then
    . ~/.rvm/scripts/rvm
    rvm use ${RUBY_VERSION-2.3.0} &> /dev/null
    tool_available "ruby" "ruby --version | cut -d' ' -f2"

    # some common ruby tools
    hash termrc 2> /dev/null || gem install termrc
fi