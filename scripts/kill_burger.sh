#!/bin/bash
#set -e
set -x

pkill -f judge

pkill -f setup_sim.launch

pkill -f  sim_robot_run.launch

pkill -f sim_with_judge.sh

pkill -f start.sh

pkill -f match_202103_yosen.sh

pkill -f final_red.launch

pkill -f final_blue.launch

pkill -f ffmpeg

pkill -f gst-launch-1.0

pkill -f rqt
