#!/usr/bin/env bash

FLOW_TARGET_VERSION="0.36.0"
TYPESCRIPT_TARGET_VERSION="2.1.4"

ELM_HOME="$(dirname $(dirname $(which node)))"/lib/node_modules/elm/share
ELM_TARGET_VERSION="0.18.0"

echo -ne "\n${YELLOW}altJS:\t${NC}"

installElm() {
    local elm_version

    if hash elm 2>/dev/null; then
        elm_version="$(elm make -h | head -n1 | sed -E 's/(\(|\))//g' | cut -f5 -d' ')"
    fi

    if [[ -z "${elm_version}" ]] || [[ "${elm_version}" != "${ELM_TARGET_VERSION}" ]]; then
        echo -e "\nInstalling / Updating elm\n"
        npm install -g elm@"${ELM_TARGET_VERSION}"
    fi

    tool_available elm "elm make -h | head -n1 | sed -E 's/(\(|\))//g' | cut -f5 -d' '"
}

installFlow() {
    local flow_version

    if hash flow 2>/dev/null; then
        flow_version="$(flow version | sed s/[^0-9.]//g)"
    fi

    if [[ -z "${flow_version}" ]] || [[ "${flow_version}" != "${FLOW_TARGET_VERSION}" ]]; then
        echo -e "\nInstalling / Updating flow\n"
        npm install -g flow-bin@"${FLOW_TARGET_VERSION}"
    fi

    tool_available flow "flow version | sed s/[^0-9.]//g"
}

# typescript
hash tsc 2> /dev/null || npm install -g typescript@"${TYPESCRIPT_TARGET_VERSION}"
hash tsc && tool_available tsc "tsc --version | cut -f2 -d' '" typescript

# haxe
hash haxe 2> /dev/null || npm install -g haxe
tool_available haxe "haxe | head -n1 | cut -f3 -d' '"

installFlow
installElm
