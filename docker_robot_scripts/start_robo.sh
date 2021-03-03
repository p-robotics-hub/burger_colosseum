#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
CONTAINER_VER=`echo $SCRIPT_DIR | cut -d / -f 4 | sed -e 's/catkin_ws_//'`
BURGER_DIR=$(cd $(dirname $0); pwd)/../../../
echo CONTAINER_VER : $CONTAINER_VER

echo -n "Please input side [r/b]:"
read SIDE
echo $SIDE
if [ $SIDE = "r" ]; then
	RUNSCRIPT="match_202103_honsen.sh"
elif [ $SIDE = "b" ]; then
	RUNSCRIPT="match_202103_honsen_blue.sh"
else
	echo "Please input r/b"
	exit
fi

set -x
cd ${BURGER_DIR}/src/burger_war_dev/
bash commands/kit.sh -t robo -c /home/developer/catkin_ws/src/burger_colosseum/robot_scripts/${RUNSCRIPT}

set +x
