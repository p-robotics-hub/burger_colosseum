#!/bin/bash

#require: sudo apt install wmctrl xdotool

# Set windows position for Gazebo and JUDGE Window.
# Minimize windows of gnome-terminal(s)

TERMINALS=`xdotool search -onlyvisible gnome-terminal`
for WINID in ${TERMINALS} ; do
 xdotool windowminimize ${WINID}
done

GAZEBOWIN=`xdotool search -onlyvisible Gazebo | head -1`
xdotool windowactivate ${GAZEBOWIN}
wmctrl -r Gazebo -b remove,maximized_vert,maximized_horz
xdotool windowsize ${GAZEBOWIN} 1000 700
xdotool windowmove ${GAZEBOWIN} 10 10
sleep 0.2

xdotool mousemove 270 380
sleep 0.2
xdotool click 1
sleep 0.2
xdotool mousedown 1
sleep 0.2
xdotool mousemove 100 380
sleep 0.2
xdotool mouseup 1
sleep 0.2

xdotool key Alt+v
xdotool key Return
xdotool key Alt+v
xdotool key Down
xdotool key Return
xdotool key Ctrl+h

xdotool windowsize ${GAZEBOWIN} 700 700
xdotool windowmove ${GAZEBOWIN} 10 10

#xdotool windowsize ${GAZEBOWIN} 85% 100%
#xdotool windowmove ${GAZEBOWIN} 130 10

JUDGE=`xdotool search -onlyvisible "burger war"`
xdotool windowactivate ${JUDGE}
xdotool windowmove ${JUDGE} 710 10


RQT=`xdotool search -onlyvisible rqt_image_view | head -1`
xdotool windowactivate ${RQT}
xdotool windowsize ${RQT} 500 500
xdotool windowmove ${RQT} 710 160

xdotool windowactivate ${JUDGE}
