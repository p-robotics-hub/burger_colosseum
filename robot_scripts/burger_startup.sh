#!/bin/bash

#cd ~/wss/OneNightROBOCON_ws/src/burger_war
#source ~/wss/OneNightROBOCON_ws/devel/setup.bash

IPADDR=http://192.168.0.100:5000
echo side:$1
echo player_name:$2

roslaunch burger_war setup.launch ip:=$IPADDR side:=$1 player_name:=$2
