#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

gnome-terminal -- ${SCRIPT_DIR}/autostartup.sh
