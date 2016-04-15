#!/usr/bin/env bash
[[ -e ~/.rvm/scripts/rvm ]] && . ~/.rvm/scripts/rvm
hash rvm && rvm use ${RUBY_VERSION-2.3.0} &> /dev/null
hash ruby && echo "ruby:   $(ruby --version | cut -d' ' -f2)"
