# #!/usr/bin/env bash

# opam initialisation (ocaml)
if [[ -e "${HOME}/.opam/opam-init/init.sh" ]]; then
  "${HOME}"/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

  hash ocaml 2> /dev/null && tool_available "ocaml" "ocaml --version | cut -f5 -d' '"
fi
