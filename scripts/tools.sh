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
      yarn global add "${tool}"@"${target_version}"
  fi

  tool_available "${tool}" "${get_version}"
}

# hash mert 2> /dev/null || npm install -g mert
# tool_available mert "mert --version"

# hash webpack 2> /dev/null || yarn global add webpack
# tool_available webpack "webpack --version"

# # installTool "flow-typed" "echo $(flow-typed version) | cut -c 12-" "${FLOWTYPED_VERSION}"
