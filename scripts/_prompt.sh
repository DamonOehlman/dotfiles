#!/usr/bin/env bash
red='\e[0;31m'
RED='\e[1;31m'
green='\e[0;32m'
GREEN='\e[1;32m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
blue='\e[0;34m'
BLUE='\e[1;34m'
magenta='\e[0;35m'
MAGENTA='\e[1;35m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'              # No Color

# Taken from http://www.opinionatedprogrammer.com/2011/01/colorful-bash-prompt-reflecting-git-status/
function _git_prompt() {
  local git_status
  local ansi

  git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      ansi=$GREEN
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      ansi=$RED
    else
      ansi=$YELLOW
    fi
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
      #test "$branch" != master || branch=' '
    else
      # Detached HEAD.  (branch=HEAD is a faster alternative.)
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
      echo HEAD`)"
    fi
    echo -n ' ⇾ '"$ansi"'\]'"$branch""$NC"'\]'
  fi
}

function report_status() {
  RET_CODE=$?
  if [[ $RET_CODE -ne 0 ]] ; then
    echo -ne " [\[$RED\]$RET_CODE\[$NC\]]"
  fi
}

function prompt_head() {
  echo -ne "\n➡️  \w\[$NC\]"
}

function prompt_tail() {
  echo -ne "\\n👤  \u \[$NC\]"
}

export _PS1="\[$NC\] \w"
export PS2="\[$NC\]> "
export PROMPT_COMMAND='_status=$(report_status);export PS1="$(prompt_head)$(_git_prompt)${_status}$(prompt_tail)\$ ";unset _status;'
