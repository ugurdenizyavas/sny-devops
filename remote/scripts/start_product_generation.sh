#!/bin/bash
WORKING_DIR="/opt/shared/scripts"

sh ${WORKING_DIR}/start.sh -p 9095 -j octopus3-product-generation-service-app.jar -e dev -l /opt/logs/product-generation -n octopus3-product-generation-service

