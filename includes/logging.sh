tool_available() {
    local tool=$1
    local version_command=$2
    local tool_label=$3
    local version

    if [[ -z "${tool_label}" ]]; then
      tool_label="${tool}"
    fi

    hash "${tool}" 2> /dev/null
    if [[ "$?" = 0 ]]; then
        version="$(eval "${version_command}")"
        echo -ne "${GREEN}${3:-${tool_label}}${green}[${version}]${NC} "
    fi
}
