#!/usr/bin/env bash
PYENV_EXECUTABLE=""
if [[ -e "~/pyenv/bin/pyenv" ]]; then
  PYENV_EXECUTABLE="~/pyenv/bin/pyenv"
elif [[ -e "/usr/local/bin/pyenv" ]]; then
  PYENV_EXECUTABLE="/usr/local/bin/pyenv"
fi

if [[ ! -z "${PYENV_EXECUTABLE}" ]]; then
    eval "$(pyenv init -)"
    pyenv global ${PYTHON_VERSION-2.7.9}
    tool_available "python" "python --version 2>&1 | cut -d' ' -f2"

    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="~/.pyenv/versions/$(python --version 2>&1 | cut -d' ' -f2)/bin:$PYENV_ROOT/bin:$PATH"
fi
