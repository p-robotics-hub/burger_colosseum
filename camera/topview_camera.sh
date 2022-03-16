# sudo apt install gstreamer1.0-plugins-bad

gst-launch-1.0 v4l2src ! video/x-raw,width=640,height=480,framerate=30/1  ! videoconvert ! rotate angle=0.78 !  ximagesink
#gst-launch-1.0 v4l2src ! video/x-raw,width=1280,height=720,framerate=10/1  ! videoconvert ! rotate angle=0.78 !  ximagesink
