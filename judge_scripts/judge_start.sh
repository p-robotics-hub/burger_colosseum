#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

source ${SCRIPT_DIR}/../../../devel/setup.bash

roscd burger_war/../

gnome-terminal -- python judge/judgeServer.py --mt 180 --et 60
python judge/JudgeWindow.py&
firefox http://192.168.0.100:5000/
