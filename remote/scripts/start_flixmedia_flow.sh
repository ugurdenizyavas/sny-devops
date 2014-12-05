#!/bin/bash
WORKING_DIR="/opt/shared/devops/scripts"

sh ${WORKING_DIR}/start.sh -p 9094 -j octopus3-flixmedia-flow-service-app.jar -e $1 -l /opt/logs/flixmedia-flow -n octopus3-flixmedia-flow-service -wd ${WORKING_DIR}

