#!/bin/bash
WORKING_DIR="/opt/shared/devops/scripts"
jvm="-server -Djava.net.preferIPv4Stack=true -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+AlwaysPreTouch -XX:ThreadStackSize=4096 -Xmx1024m -Xms512m"

sh ${WORKING_DIR}/start.sh -p 9095 -j octopus3-product-generation-service-app.jar -l /opt/logs/product-generation -n octopus3-product-generation-service
