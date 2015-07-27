#!/usr/bin/env bash
function roxterm_tweak() {
  dbus-send --session /net/sf/roxterm/Options \
    net.sf.roxterm.Options.$1 \
    string:$ROXTERM_ID string:${2:-Default}
}