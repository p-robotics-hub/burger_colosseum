#!/bin/bash

# This script using /mnt/tmp 
# Because I use aws ec2 instance to run this script.
# /mnt is temporary file storage. It's very fast file access.
# If you use local computer, please change "TMP_DIR" to other path.

# If the window to be captured is completely hidden, the capture process will not work.

DESKTOPWIDTH=`xdpyinfo  | grep -oP 'dimensions:\s+\K\S+' | cut -f 1 -d "x"`
DESKTOPHEIGHT=`xdpyinfo  | grep -oP 'dimensions:\s+\K\S+' | cut -f 2 -d "x"`


TMP_DIR=/mnt/tmp
sudo mkdir -p ${TMP_DIR}
sudo chmod 777 ${TMP_DIR}


WLIST=`wmctrl -l`

XID_GAZEBO=`echo "$WLIST" | grep Gazebo | awk '{print $1}'| head -1`
XID_JUDGE=`echo "$WLIST" | grep 'burger war' | awk '{print $1}'| head -1`
XID_RVIZ=`echo "$WLIST" | grep 'RViz' | awk '{print $1}'| head -1`


(gst-launch-1.0 ximagesrc xid=$XID_GAZEBO ! queue ! video/x-raw,framerate=10/1 ! jpegenc ! avimux ! filesink location="${TMP_DIR}/01.avi")&
(gst-launch-1.0 ximagesrc xid=$XID_JUDGE ! queue ! video/x-raw,framerate=1/1 ! jpegenc ! avimux ! filesink location="${TMP_DIR}/02.avi")&
#(gst-launch-1.0 ximagesrc xid=$XID_RVIZ ! video/x-raw,framerate=10/1 ! jpegenc ! avimux ! filesink location="${TMP_DIR}/03.avi")&

(gst-launch-1.0 ximagesrc ! queue ! video/x-raw,framerate=10/1 ! jpegenc ! avimux ! filesink location="${TMP_DIR}/00.avi")&


