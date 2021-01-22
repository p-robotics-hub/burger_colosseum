#!/bin/bash

#require: sudo apt install wmctrl xdotool

# Set windows position for Gazebo and JUDGE Window.
# Minimize windows of gnome-terminal(s)

TERMINALS=`xdotool search -onlyvisible gnome-terminal`
for WINID in ${TERMINALS} ; do
 xdotool windowminimize ${WINID}
done

JUDGE=`xdotool search -onlyvisible "burger war"`
xdotool windowactivate ${JUDGE}


