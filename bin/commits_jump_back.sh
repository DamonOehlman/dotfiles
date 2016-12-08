#!/usr/bin/env bash
get_previous_commit() {
	git log master --format="%h" | grep -A 1 $(git log -n1 --format="%h") | tail -n 1
}

main() {
  git checkout "$(get_previous_commit)"
}

main "$@"
