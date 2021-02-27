#!/bin/bash
SIM_DIR=~/catkin_ws_sim/src
echo 'Input Github User name (xxxxx -> https://github.com/xxxxx/burger_war_dev)'
read GIT_USER

MY_DIR=~/catkin_ws_${GIT_USER}
mkdir -p ${MY_DIR}/src
cd ${MY_DIR}/src

git clone https://github.com/${GIT_USER}/burger_war_dev

cp -R ${SIM_DIR}/burger_war_kit .
cp -R ${SIM_DIR}/burger_colosseum .

cp -R ${SIM_DIR}/burger_war_dev/docker/sim burger_war_dev/docker/
cp ${SIM_DIR}/burger_war_dev/commands/docker-launch.sh burger_war_dev/commands/

sed -i -e "s|^HOST_WS_DIR.*|HOST_WS_DIR=${MY_DIR}|" burger_war_dev/commands/config.sh

echo Enter : ${MY_DIR}/src/burger_colosseum/docker_scripts
