#!/bin/bash

SD=$(cd $(dirname $0); pwd)

TMP_DIR=/mnt/tmp
sudo mkdir -p ${TMP_DIR}
sudo chmod 777 ${TMP_DIR}

${SD}/movie_add_capture.sh "$1 vs チーズバーガー" ~/*cheese.mp4 ${TMP_DIR}/01.mp4

${SD}/movie_add_capture.sh "$1 vs てりやきバーガー" ~/*teriyaki.mp4 ${TMP_DIR}/02.mp4

${SD}/movie_add_capture.sh "$1 vs クラブハウス" ~/*clubhouse.mp4 ${TMP_DIR}/03.mp4

cat << EOF > ${TMP_DIR}/text.text
file ${TMP_DIR}/01.mp4
file ${TMP_DIR}/02.mp4
file ${TMP_DIR}/03.mp4
EOF

ffmpeg -safe 0 -f concat -i ${TMP_DIR}/text.text -c:v copy -c:a copy -c:s copy -map 0:v ${TMP_DIR}/out.mp4

mv  ${TMP_DIR}/out.mp4 ~/"$1.mp4"

