#!/bin/bash
WORKING_DIR="/opt/shared/devops/scripts"

sh ${WORKING_DIR}/start.sh -j octopus3-repository-service-app.jar -p 9091 -l /opt/logs/repository -n octopus3-repository-service -wd ${WORKING_DIR}

