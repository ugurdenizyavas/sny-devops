#!/bin/bash
WORKING_DIR="/opt/shared/devops/scripts"

sh ${WORKING_DIR}/start.sh -p 9098 -j octopus3-sony1-flow-service-app.jar -e $1 -l /opt/logs/sony1-flow -n octopus3-sony1-flow-service -wd ${WORKING_DIR}

