#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# directory configuration
source ${SCRIPT_DIR}/config.sh
ROS_SETUP=/opt/ros/melodic




set -e
set -x #debug mode


source ${ROS_SETUP}/setup.bash
source ${BURGER_DIR}/devel/setup.bash
export TURTLEBOT3_MODEL=burger

# prosess start backgreound
# please kill_onigiri.sh for kill prosess

# check arg num
if [ $# -ne 2 ]; then
    echo "ERR arguments num ERR $#"
    exit 1
fi

RED_NAME=$1
BLUE_NAME=$2

case $BLUE_NAME in
    "cheese")
        ENEMY="sim_robot_run.launch enemy_level:=1";;
    "teriyaki")
        ENEMY="sim_robot_run.launch enemy_level:=2";;
    "clubhouse")
        ENEMY="sim_robot_run.launch enemy_level:=3";;
    *)
        ENEMY="sim_robot_run.launch enemy_level:=1";;
esac
echo $ENEMY
#echo break && read input


# launch Simulation 
roscd burger_war/..
(
bash scripts/sim_with_judge.sh $RED_NAME $BLUE_NAME
)&


#echo break && read input
sleep 10
rqt_image_view /aruco_marker_publisher/result/compressed &


# set window position and size
sleep 3
bash ${SCRIPT_DIR}/set_window_pos.sh
sleep 5


# launch your_burger as red side / launch enemy as blue side
gnome-terminal -- bash -c "(
source ${ROS_SETUP}/setup.bash
source ${BURGER_DIR}/devel/setup.bash
export TURTLEBOT3_MODEL=burger
roslaunch burger_war ${ENEMY}
)"

#${SCRIPT_DIR}/record_desktop.sh ~/${RED_NAME}-${BLUE_NAME}.mp4 &
${SCRIPT_DIR}/record_windows.sh


# set judge server state "running"
roscd burger_war/..
bash judge/test_scripts/set_running.sh localhost:5000



# set window position

bash ${SCRIPT_DIR}/set_window_pos2.sh
