#!/usr/bin/env bash
get_next_commit() {
	git log master --format="%h" | grep -B 1 $(git log -n1 --format="%h") | head -n 1
}

main() {
	git reset --hard HEAD
  git checkout "$(get_next_commit)"
}

main "$@"
