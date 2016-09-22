#!/usr/bin/env bash
[[ -e ~/.opam/opam-init/init.sh ]] && .opam/opam-init/init.sh > /dev/null 2> /dev/null || true
hash opam && eval `opam config env`
hash opam && opam switch ${OCAML_VERSION-4.02.3}
tool_available ocaml "ocaml -vnum"

#export PATH="~/.pyenv/versions/$(python --version 2>&1 | cut -d' ' -f2)/bin:$PATH"
