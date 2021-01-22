#!/bin/bash

# Dependencies: sudo apt install ffmpeg

TMP_DIR=/mnt/tmp

pushd ${TMP_DIR}

ffmpeg -i 01.avi -vf pad=w=iw+400:h=ih:x=0:y=0:color=black 01_.mp4
ffmpeg -i 00.avi -vf scale=400:-1 00_.mp4
ffmpeg -i 02.avi -vf scale=-1:200 -vcodec mjpeg 02_.avi
ffmpeg -i 03.avi -vf scale=-1:260 03_.mp4

ffmpeg -i 01_.mp4 -vf "movie=02_.avi[inner]; [in][inner] overlay=700:0 [out]" o.mp4
ffmpeg -i o.mp4 -vf "movie=03_.mp4[inner]; [in][inner] overlay=700:450 [out]" o2.mp4
ffmpeg -i o2.mp4 -vf "movie=00_.mp4[inner]; [in][inner] overlay=700:200 [out]" o3.mp4

popd

cp ${TMP_DIR}/o3.mp4 $1
