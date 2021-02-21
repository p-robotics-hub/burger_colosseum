#!/bin/sh

sudo mkdir /mnt/tmp
sudo chmod 777 /mnt/tmp
cd ~/catkin_ws/src/burger_war_dev/
bash commands/docker-launch.sh -t sim -a "--mount type=bind,src=/mnt/tmp,dst=/mnt/tmp"
