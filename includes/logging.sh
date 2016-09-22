tool_available() {
    local tool=$1
    local version_command=$2
    local version

    hash "${tool}" 2> /dev/null
    if [[ "$?" = 0 ]]; then
        version="$(eval "${version_command}")"
        echo -ne "${GREEN}${tool}${green}[${version}]${NC} "
    fi
}
