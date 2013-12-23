# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:~/.local/bin

# CUSTOM CONFIGURATIONS

## initialise code home
export CODE_HOME=$HOME/code

## node
NODE_VERSION=0.10.24

## initialise google depot_tools
export PATH=$PATH:$CODE_HOME/goog/depot_tools

## load rvm
[[ -d ~/.rvm ]] && source ~/.rvm/scripts/rvm

## BB10 Dev Environment

BBNDK=~/bbndk
BB_HOST_VERSION=10_2_0_15
BB_HOST_ENV=$BBNDK/host_$BB_HOST_VERSION/linux/x86

export CORDOVA_BBTOOLS=$BB_HOST_ENV/usr/bin

## Android Dev Environment
export ANDROID_HOME=/opt/android-sdk-linux
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# bashinate
PATH=$PATH:$HOME/.bashinate/bin:$CODE_HOME/DamonOehlman/bashinate
PATH=$PATH:`bashinate use node $NODE_VERSION`
bashinate use rust 0.7
bashinate use luvit 0.6.1
bashinate use phantomjs 1.9.2
bashinate use appengine-go
bashinate use couchdb 1.5.0

# java
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64

# haskell
export PATH=$HOME/.cabal/bin:$PATH

# emscripten
export PATH=$PATH:~/code/github/emscripten
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# perlbrew
# source ~/perl5/perlbrew/etc/bashrc
# added by travis gem
[ -f /home/doehlman/.travis/travis.sh ] && source /home/doehlman/.travis/travis.sh

# load secrets
source ~/.secrets.sh
