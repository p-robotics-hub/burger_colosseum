#!/bin/bash
SIM_DIR=~/catkin_ws_sim/src
if [ $# -ne 1 ]; then
	echo './clone_ws.sh Github_Username'
	echo '(xxxxx -> https://github.com/xxxxx/burger_war_dev)'
	exit 1
fi
GIT_USER=$1

MY_DIR=~/catkin_ws_${GIT_USER}
mkdir -p ${MY_DIR}/src
cd ${MY_DIR}/src

git clone https://github.com/${GIT_USER}/burger_war_dev

echo Copying burger_war_kit and burger_colosseum from catkin_ws_sim
cp -R ${SIM_DIR}/burger_war_kit .
cp -R ${SIM_DIR}/burger_colosseum .

echo Copying docker configuration files from catkin_ws_sim
cp -R ${SIM_DIR}/burger_war_dev/docker/sim burger_war_dev/docker/
cp ${SIM_DIR}/burger_war_dev/commands/docker-launch.sh burger_war_dev/commands/

echo Changing work space directory
sed -i -e "s|^HOST_WS_DIR.*|HOST_WS_DIR=${MY_DIR}|" burger_war_dev/commands/config.sh

echo Changing CHALLENGER name
sed -i -e "s/CHALLENGER=.*/CHALLENGER=${GIT_USER}/" burger_colosseum/auto_start/init_settings

echo Enter : ${MY_DIR}/src/burger_colosseum/docker_scripts
