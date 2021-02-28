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


echo ---------1st match---------
bash ${SCRIPT_DIR}/launch_docker_wait_finish.sh
echo ---------2nd match---------
bash ${SCRIPT_DIR}/launch_docker_wait_finish.sh
echo ---------3rd match---------
bash ${SCRIPT_DIR}/launch_docker_wait_finish.sh

set +x
