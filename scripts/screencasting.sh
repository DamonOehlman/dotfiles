#!/usr/bin/env bash
function screencast() {
	TMP_AVI=$(mktemp /tmp/outXXXXXXXXXX.avi)
	OUTPUT_GIF=~/Videos/$(date '+%Y-%m-%d_%H-%M-%S').gif

	ffcast -s % ffmpeg -y -f x11grab -show_region 1 -framerate 15 \
		-video_size %s -i %D+%c -codec:v huffyuv \
		-vf crop="iw-mod(iw\\,2):ih-mod(ih\\,2)" $TMP_AVI

	convert -set delay 10 -layers Optimize $TMP_AVI $OUTPUT_GIF
}

hash ffmpeg 2> /dev/null || echo "could not locate ffmpeg, install ppa: https://launchpad.net/~mc3man/+archive/ubuntu/trusty-media"
hash ffcast 2> /dev/null || echo "no ffcast, visit: https://github.com/lolilolicon/FFcast"
hash xrectsel 2> /dev/null || echo "no xrectsel, visit: https://github.com/lolilolicon/xrectsel"