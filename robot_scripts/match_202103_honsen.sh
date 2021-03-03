#!/bin/bash
set -x
source ~/catkin_ws/devel/setup.bash

# directory configuration
SCRIPT_DIR=$(cd $(dirname $0); pwd)
JUDGE_IP=192.168.0.100

roscd burger_war_dev/..
BURGER_DEV_DIR=`pwd`

${SCRIPT_DIR}/display_name.sh `${SCRIPT_DIR}/get_git_info.sh $BURGER_DEV_DIR`

roscd burger_war/..
bash judge/test_scripts/set_running.sh ${JUDGE_IP}:5000

roslaunch ${SCRIPT_DIR}/../launch/final_red.launch

set +x
