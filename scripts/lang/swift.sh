#!/usr/bin/env bash
export PATH="/usr/share/swift/usr/bin:$PATH"
hash swift && tool_available "swift" "swift --version | head -n1 | cut -f3 -d' '"

