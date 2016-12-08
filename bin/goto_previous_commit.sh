#!/usr/bin/env bash
get_previous_commit() {
	git log master --format="%h" | grep -B 1 $(git log -n1 --format="%h") | head -n 1
}

main() {
  git checkout "$(get_previous_commit)"
}

main "$@"
