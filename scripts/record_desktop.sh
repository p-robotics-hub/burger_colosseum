#!/bin/bash

DESKTOPWIDTH=`xdpyinfo  | grep -oP 'dimensions:\s+\K\S+' | cut -f 1 -d "x"`
DESKTOPHEIGHT=`xdpyinfo  | grep -oP 'dimensions:\s+\K\S+' | cut -f 2 -d "x"`

TMP_DIR=/mnt/tmp
sudo mkdir -p ${TMP_DIR}
sudo chmod 777 ${TMP_DIR}


ffmpeg -f x11grab -y -r 10 -s ${DESKTOPWIDTH}x${DESKTOPHEIGHT} -i :0.0 -vcodec ffvhuff ${TMP_DIR}/out.avi
ffmpeg -y -i ${TMP_DIR}/out.avi -crf 35 $1
rm ${TMP_DIR}/out.avi

