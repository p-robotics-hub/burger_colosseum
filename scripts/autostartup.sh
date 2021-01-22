#!/bin/bash

# function definision
function countDown() {
  start=1
  end=20
  echo "reboot after $end seconds"
  while [[ $start -le $end ]]; do
    echo $(($end-$start))
    sleep 1
    start=$(($start+1))
  done
}


SCRIPT_DIR=$(cd $(dirname $0); pwd)
AUTO_START=${SCRIPT_DIR}/../auto_start

echo $SCRIPT_DIR
echo $AUTO_START


echo sleep 10 seconds
sleep 10

source ~/.bashrc

for file in `find ${AUTO_START}/*.sh -maxdepth 1 -type f | sort`;do
	echo $file
	source $file
	mv $file ${file}~
	echo "Execution finished : " $file
	countDown
	sudo reboot
	break
done


