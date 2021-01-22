#!/bin/bash
set -e
set -x

ACCOUNT_NAME=$1

# if acount name head is "#" skip script
# "#" means comment
if [[ ${ACCOUNT_NAME} == "#"* ]]; then
    exit
fi


# if no workspace, make ws, init ,clone
if [ -d  ~/wss/${ACCOUNT_NAME}_ws/src ]; then
    echo "~/wss/${ACCOUNT_NAME}_ws/src is already exist. So skip make ws"

else
    mkdir -p ~/wss/${ACCOUNT_NAME}_ws/src
    cd ~/wss/${ACCOUNT_NAME}_ws/src
    catkin_init_workspace
    cd ~/wss/${ACCOUNT_NAME}_ws
    catkin_make
fi


# get newest code from repo
if [ -d  ~/wss/${ACCOUNT_NAME}_ws/src/burger_war ]; then
    # pull repo if exist already
    cd ~/wss/${ACCOUNT_NAME}_ws/src/burger_war
    git pull
else
    # clone repo if not exist
    cd ~/wss/${ACCOUNT_NAME}_ws/src
    git clone http://github.com/${ACCOUNT_NAME}/burger_war.git
fi


# make
cd ~/wss/${ACCOUNT_NAME}_ws
catkin_make
