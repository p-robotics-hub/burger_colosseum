#!/bin/bash
fn="\$1"
of=\${fn%.*}.jpg
lf=\`ffprobe -show_streams "\$fn" 2> /dev/null | awk -F= '/^nb_frames/ { print \$2-1 }'\`
rm -f "\$of"
ffmpeg -i "\$fn" -vf "select='eq(n,\$lf)'" -vframes 1 "\$of" 2> /dev/null
