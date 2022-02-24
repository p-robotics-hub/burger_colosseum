#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
CONTAINER_VER=`echo $SCRIPT_DIR | cut -d / -f 4 | sed -e 's/catkin_ws_//'`
BURGER_DIR=$(cd $(dirname $0); pwd)/../../../

echo CONTAINER_VER : $CONTAINER_VER

echo -n "Please input side [r/b]:"
read SIDE
echo $SIDE
if [ $SIDE = "r" ]; then
	SIDE_S="r red"
elif [ $SIDE = "b" ]; then
	SIDE_S="b blue"
else
	echo "Please input r/b"
	exit
fi


set -x
cd ${BURGER_DIR}/src/burger_war_dev/
bash commands/docker-launch.sh -f -t robo -v $CONTAINER_VER 
sleep 5
bash commands/kit.sh -t robo -c catkin build
sleep 5
bash commands/kit.sh -t robo -c /home/developer/catkin_ws/src/burger_colosseum/robot_scripts/fix_permission.sh
sleep 5
bash commands/kit.sh -t robo -c /home/developer/catkin_ws/src/burger_colosseum/robot_scripts/burger_startup.sh $SIDE_S


set +x
