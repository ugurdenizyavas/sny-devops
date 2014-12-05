#!/bin/bash
WORKING_DIR="/opt/shared/devops/scripts"


sh ${WORKING_DIR}/start.sh -p 9096 -j octopus3-admin-app.jar -e $1 -l /opt/logs/admin -n octopus3-admin -wd ${WORKING_DIR}

