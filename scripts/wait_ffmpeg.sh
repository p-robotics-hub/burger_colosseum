#!/bin/bash

CNT=0
while [ $CNT -le 2 ]
do
    sleep 1
    FFMPEG_PS=`ps ax | grep ffmpeg | grep -v grep | grep -v wait_ffmpeg.sh | wc -l`
    echo waiting $FFMPEG_PS : $CNT
    if [ $FFMPEG_PS -eq 0 ] ; then
        let CNT++
    fi
done
