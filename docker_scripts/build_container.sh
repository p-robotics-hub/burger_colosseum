#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
CONTAINER_VER=`echo $SCRIPT_DIR | cut -d / -f 4 | sed -e 's/catkin_ws_//'`
source ${SCRIPT_DIR}/../scripts/config.sh

echo CONTAINER_VER : $CONTAINER_VER

cd ${BURGER_DIR}/src/burger_war_dev/
bash commands/docker-build.sh -t sim -v $CONTAINER_VER
