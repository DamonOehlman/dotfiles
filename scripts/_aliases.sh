#!/usr/bin/env bash

# git aliases
alias recent_branches="git for-each-ref --count=30 --sort=-committerdate refs/heads --format='%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(authorname)%(color:reset)' |column -ts'|'"

# initialise the bashrc
# alias chrome="rm -rf $HOME/.config/chrome-test && google-chrome --console --no-first-run --user-data-dir=$HOME/.config/chrome-test --use-fake-device-for-media-stream --use-file-for-fake-video-capture=/home/doehlman/testvideo.y4m --enable-logging --v=1 --vmodule=*third_party/libjingle/*=3,*=0"
alias chrome="rm -rf $HOME/.config/chrome-test && google-chrome --console --no-first-run --user-data-dir=$HOME/.config/chrome-test --enable-usermedia-screen-capturing --allow-http-screen-capture --use-fake-device-for-media-stream --enable-logging --v=1 --vmodule=*third_party/libjingle/*=3,*=0"

alias bsize="browserify . --standalone test | uglifyjs | wc -c"
alias bcheck="browserify . | uglifyjs index.js --screw-ie8 --mangle --compress > /dev/null"

alias dockercleancontainers="docker ps -a --no-trunc| grep 'Exit' | awk '{print \$1}' | xargs -L 1 -r docker rm"
alias dockercleanimages="docker images -a --no-trunc | grep none | awk '{print \$3}' | xargs -L 1 -r docker rmi"
alias dockerclean="dockercleancontainers && dockercleanimages"

# screen customization options
alias layout_work="xrandr --addmode HDMI1 $VM_WORK && xrandr --output HDMI1 --primary --mode $VM_WORK --output $DISPLAY_INTERNAL --off" #--left-of eDP1 && xrandr --output eDP1 --primary"
alias layout_laptop="xrandr --output $DISPLAY_INTERNAL --mode 1920x1080 --primary --output HDMI1 --off"
alias layout_scaled="xrandr --addmode $DISPLAY_INTERNAL INTERNAL_SCALED && xrandr --output $DISPLAY_INTERNAL --mode INTERNAL_SCALED --primary --output HDMI1 --off"
alias layout_canva="xrandr --addmode HDMI1 1920x1200 && xrandr --output HDMI1 --primary --mode 1920x1200 --output $DISPLAY_INTERNAL --off"
alias layout_home="xrandr --addmode HDMI2 1920x1080 && xrandr --output HDMI2 --primary --mode 1920x1080 --output $DISPLAY_INTERNAL --off"

# my helpful readme command
alias lynxme="pandoc -f markdown_github - | lynx -stdin"
alias readme="echo &1 && cat ~/code/$1/README.md > /dev/null 2> /dev/null && pandoc -f markdown_github - | lynx -stdin"
alias readmod="cat node_modules/$1/README.md > /dev/null 2> /dev/null && pandoc -f markdown_github - | lynx -stdin"

# some helpful git aliases
alias mast="git checkout master"

# wallpaper switcher
alias wallpaper_next="nitrogen --set-zoom-fill ~/Pictures/wallpaper/\$(ls ~/Pictures/wallpaper/ |sort -R |tail -1)"

# update .bithoundrc to match my default
alias bithound="curl -s https://gist.githubusercontent.com/DamonOehlman/df7dfcf648fd91268ec0/raw/8ea910d278dc3aee3c8e69d5800b0fbb731c936e/.bithoundrc > .bithoundrc"

# an alias to change the colorscheme of the current roxterm terminal
alias scheme="roxterm_tweak SetColourScheme"
