#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)


cd ${SCRIPT_DIR}/../../burger_war_kit/

gnome-terminal -- python judge/judgeServer.py --mt 180 --et 60
python judge/JudgeWindow.py&
firefox http://localhost:5000/&
