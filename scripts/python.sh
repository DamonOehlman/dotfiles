#!/usr/bin/env bash
if [[ -e ~/pyenv/bin/pyenv ]]; then
    eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"
    pyenv global ${PYTHON_VERSION-2.7.9}
    tool_available "python" "python --version 2>&1 | cut -d' ' -f2"

    export PATH="~/.pyenv/versions/$(python --version 2>&1 | cut -d' ' -f2)/bin:$PATH"
fi