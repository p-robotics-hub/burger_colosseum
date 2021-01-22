#!/bin/bash

REPO=`cat $1/.git/config | grep url | cut -f 4 --delimiter="/"`

echo  -n $REPO

