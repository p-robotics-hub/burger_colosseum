#!/bin/bash

#sudo usermod -a -G dialout ubuntu
sudo chmod a+rw /dev/ttyACM0
sudo chmod a+rw /dev/ttyUSB0
sudo chmod a+rw /dev/video*
