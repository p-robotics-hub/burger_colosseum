#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

pushd ${SCRIPT_DIR}/../auto_start
mv 01.sh~ 01.sh
mv 02.sh~ 02.sh
mv 03.sh~ 03.sh
popd
