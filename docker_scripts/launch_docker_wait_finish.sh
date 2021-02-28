#!/bin/bash
set -x
SCRIPT_DIR=$(cd $(dirname $0); pwd)
CONTAINER_VER=`echo $SCRIPT_DIR | cut -d / -f 4 | sed -e 's/catkin_ws_//'`
source ${SCRIPT_DIR}/../scripts/config.sh

echo CONTAINER_VER : $CONTAINER_VER

rm -f $TMP_DIR/finish

cd ${BURGER_DIR}/src/burger_war_dev/
bash commands/docker-launch.sh -f -t sim -v $CONTAINER_VER -a "--mount type=bind,src=/mnt/tmp,dst=/mnt/tmp"
sleep 5
bash commands/kit.sh -t sim -c catkin build
sleep 5
bash commands/kit.sh -t sim -c /home/developer/catkin_ws/src/burger_colosseum/scripts/autostartup_exec.sh

set +x
# finishファイルが現れるまで待つ
echo wait to finish the match
while [ ! -f $TMP_DIR/finish ]; do
	#echo waiting
	sleep 1
done
set -x
rm $TMP_DIR/finish

set +x
