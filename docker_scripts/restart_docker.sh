#!/bin/bash
set -x
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ${SCRIPT_DIR}/../scripts/config.sh

# finishファイルが現れるまで待つ
while [ ! -f $TMP_DIR/finish ]; do
	#echo waiting
	sleep 1
done
rm $TMP_DIR/finish
docker restart burger-war-sim
sleep 10
cd ${BURGER_DIR}/src/burger_war_dev/
bash commands/kit.sh -t sim -c /home/developer/catkin_ws/src/burger_colosseum/scripts/autostartup_exec.sh

sleep 15
CK_TMP=`bash commands/kit.sh -t sim -c "ps ax" | grep sim_with_judge | wc -l`
while [ ! $CK_TMP = 1 ]; do
	bash commands/kit.sh -t sim -c /home/developer/catkin_ws/src/burger_colosseum/scripts/autostartup_exec.sh
	sleep 15
	CK_TMP=`bash commands/kit.sh -t sim -c "ps ax" | grep sim_with_judge | wc -l`
done
set +x
