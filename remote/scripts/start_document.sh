#!/bin/bash
WORKING_DIR="/opt/shared/devops/scripts"

sh ${WORKING_DIR}/start.sh -j octopus3-document-service-app.jar -e $1 -p 9097 -l /opt/logs/document -n octopus3-document-service -wd ${WORKING_DIR}

