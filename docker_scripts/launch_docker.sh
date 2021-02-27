#!/bin/bash
set -x
SCRIPT_DIR=$(cd $(dirname $0); pwd)
CONTAINER_VER=`echo $SCRIPT_DIR | cut -d / -f 4 | sed -e 's/catkin_ws_//'`
source ${SCRIPT_DIR}/../scripts/config.sh

echo CONTAINER_VER : $CONTAINER_VER

bash ${SCRIPT_DIR}/../scripts/autostartup_enabling.sh 
if [ ! -d $TMP_DIR ]; then
	sudo mkdir $TMP_DIR
	sudo chmod 777 $TMP_DIR
fi

rm -f $TMP_DIR/finish

cd ${BURGER_DIR}/src/burger_war_dev/
bash commands/docker-launch.sh -t sim -v $CONTAINER_VER -a "--mount type=bind,src=/mnt/tmp,dst=/mnt/tmp"

sleep 5
bash commands/kit.sh -t sim -c catkin build

cd ${BURGER_DIR}/src/burger_war_dev/
bash commands/kit.sh -t sim -c /home/developer/catkin_ws/src/burger_colosseum/scripts/autostartup_exec.sh

bash ${SCRIPT_DIR}/restart_docker.sh
bash ${SCRIPT_DIR}/restart_docker.sh

set +x
