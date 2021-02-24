#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ${SCRIPT_DIR}/../scripts/config.sh
bash ${SCRIPT_DIR}/../scripts/autostartup_enabling.sh

if [ ! -d $TMP_DIR ]; then
	sudo mkdir $TMP_DIR
	sudo chmod 777 $TMP_DIR
fi

rm -f $TMP_DIR/finish

cd ${BURGER_DIR}/src/burger_war_dev/
bash commands/docker-launch.sh -t sim -a "--mount type=bind,src=/mnt/tmp,dst=/mnt/tmp"

sleep 5
cd ${BURGER_DIR}/src/burger_war_dev/
bash commands/kit.sh -t sim -c /home/developer/catkin_ws/src/burger_colosseum/scripts/autostartup_exec.sh

bash ${SCRIPT_DIR}/restart_docker.sh
bash ${SCRIPT_DIR}/restart_docker.sh
