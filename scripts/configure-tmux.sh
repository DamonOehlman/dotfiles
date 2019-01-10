#!/usr/bin/env bash

TPM_PATH=~/.tmux/plugins/tpm

install_or_update_tpm() {
  if [[ ! -d "${TPM_PATH}" ]]; then
    git clone https://github.com/tmux-plugins/tpm "${TPM_PATH}"
  fi

  pushd "${TPM_PATH}" >/dev/null
  git pull
  popd >/dev/null
}

link_tmux_configuration() {
  ln -sf "${DOTFILES_HOME}"/config/.tmux.conf ~/.tmux.conf
}

install_or_update_plugins() {
  "${TPM_PATH}"/scripts/install_plugins.sh
}

main() {
  # echo "dotfile home: ${DOTFILES_HOME}"
  install_or_update_tpm
  link_tmux_configuration
  install_or_update_plugins
}

main "$@"
