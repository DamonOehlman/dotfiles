#!/usr/bin/env bash
if [[ -e "${HOME}/.cargo/" ]]; then
  tool_available "rust" "rustc --version | cut -f2 -d' '"
fi

# # check if we have emscripten
# if [[ -e "${HOME}/.emscripten" ]]; then
#   . ~/code/github/emsdk/emsdk_env.sh > /dev/null
#   tool_available "emcc" "emcc -v 2>1 | head -n1 | cut -f10 -d' '"
# fi
