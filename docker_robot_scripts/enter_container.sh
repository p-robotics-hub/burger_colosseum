#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
CONTAINER_VER=`echo $SCRIPT_DIR | cut -d / -f 4 | sed -e 's/catkin_ws_//'`
BURGER_DIR=$(cd $(dirname $0); pwd)/../../../
echo CONTAINER_VER : $CONTAINER_VER


set -x
cd ${BURGER_DIR}/src/burger_war_dev/
bash commands/kit.sh -t robo
set +x
