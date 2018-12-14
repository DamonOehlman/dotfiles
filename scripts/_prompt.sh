#!/usr/bin/env bash

COMMAND_FAILED_EMOJI="🙈"
BRANCH_EMOJI="🌱"

# Taken from http://www.opinionatedprogrammer.com/2011/01/colorful-bash-prompt-reflecting-git-status/
function _git_prompt() {
  local git_status
  local ansi
  local branch

  git_status="`git status 2>&1 | tr '[:upper:]' '[:lower:]'`"
  if ! [[ "$git_status" =~ not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      ansi=$green
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      ansi=$magenta
    else
      ansi=$yellow
    fi
    if [[ "$git_status" =~ on\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
    else
      # Detached HEAD.  (branch=HEAD is a faster alternative.)
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
      echo HEAD`)"
    fi
    echo -ne ' '"${BRANCH_EMOJI}"'  '"\[$ansi"'\]'"$branch""\[$NC"'\]'
  fi
}

function report_status() {
  RET_CODE=$?
  if [[ $RET_CODE -ne 0 ]] ; then
    if [[ $RET_CODE -eq 130 ]]; then
      echo -ne " ${COMMAND_FAILED_EMOJI} ";
    else
      echo -ne " ${COMMAND_FAILED_EMOJI} \[$RED\]$RET_CODE\[$NC\]";
    fi
  fi
}

function term_title() {
  # language versions
  echo -ne "\033]0;"
  echo -ne " node@$(node --version | cut -c 2-) "
  echo -ne " python@$(python --version 2>&1 | cut -d' ' -f2) "
  echo -ne "\007"
}

function prompt_head() {
  local currentdir
  # remove the leading /mnt/<drive>/Users/<user> if running under WSL
  currentdir=$(pwd | sed -E "s:/mnt/[a-z]/Users/\w+/:~/:")

  echo -ne "\n${currentdir}\[$NC\]"
}

function prompt_tail() {
  echo -ne "\\n\u \[$NC\]"
}

export _PS1="\[$NC\] \w"
export PS2="\[$NC\]> "
export PROMPT_COMMAND='_status=$(report_status);export PS1="$(term_title)$(prompt_head)$(_git_prompt)${_status}$(prompt_tail)\$ ";unset _status;'
