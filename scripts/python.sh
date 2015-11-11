#!/usr/bin/env bash
[[ -e ~/.pyenv/bin/pyenv ]] && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"
hash pyenv && pyenv global ${PYTHON_VERSION-2.7.9}
hash python && echo "python: $(python --version 2>&1 | cut -d' ' -f2)"
