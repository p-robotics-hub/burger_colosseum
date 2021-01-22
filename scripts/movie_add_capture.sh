#!/bin/bash

if [ $# -ne 3 ]; then
	echo "movie_add_caption.sh caption inputmovie outputmovie"
fi

ffmpeg -i $2 -vf drawtext=fontfile="/usr/share/fonts/truetype/fonts-japanese-gothic.ttf":x=300:y=5:fontsize=36:text="$1":fontcolor=white $3
