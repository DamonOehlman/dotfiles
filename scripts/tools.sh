#!/usr/bin/env bash
FLOWTYPED_VERSION=2.0.0

echo -ne "\n${YELLOW}tools:\t${NC}"

installTool() {
  local tool=$1
  local get_version=$2
  local target_version=$3
  local tool_version

  if hash "${tool}" &2>1 >/dev/null; then
    tool_version="$(${get_version})" 2>/dev/null
  fi

  if [[ -z "${tool_version}" ]] || [[ "${tool_version}" != "${target_version}" ]]; then
      echo -e "\nInstalling / Updating ${tool} to ${target_version}\n"
      npm install -g "${tool}"@"${target_version}"
  fi

  tool_available "${tool}" "${get_version}"
}

hash eslint 2> /dev/null || npm install -g eslint
tool_available eslint "echo $(eslint --version) | cut -c 2-"

hash mert 2> /dev/null || npm install -g mert
tool_available mert "mert --version"

hash webpack 2> /dev/null || npm install -g webpack
tool_available webpack "webpack --version"

hash yarn 2> /dev/null || npm install -g yarn
tool_available yarn "yarn --version"

# installTool "flow-typed" "echo $(flow-typed version) | cut -c 12-" "${FLOWTYPED_VERSION}"
