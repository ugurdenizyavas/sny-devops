#!/bin/bash
WORKING_DIR="/opt/shared/devops/scripts"

sh ${WORKING_DIR}/start.sh -p 9092 -j octopus3-cadc-source-service-app.jar -e $1 -l /opt/logs/cadc-source -n octopus3-cadc-source-service

