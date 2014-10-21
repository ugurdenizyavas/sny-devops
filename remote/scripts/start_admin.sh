#!/bin/bash
WORKING_DIR="/opt/shared/scripts"


sh ${WORKING_DIR}/start.sh -p 9096 -j octopus3-admin-app.jar -e dev -l /opt/logs/admin -n octopus3-admin

