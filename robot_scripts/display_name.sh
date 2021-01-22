#!/bin/bash

gnome-terminal -e "bash -c \"clear && echo -n $1 && cat\"" --hide-menubar --geometry=25x1+0+0 --zoom=3.5
