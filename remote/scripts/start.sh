#!/bin/bash

####
#
# Example usage: ./start.sh -p 9091 -j octopus3-repository-service-app.jar
#
####

set -e

usage() {
    echo " USAGE:
    start.sh
    [-p || --port <port>]
    [-j || --jar <jar name>]
    [-l || --logDirectory <log directory>]
    [-n || --name <name of server>]
    [-x || --extras <extra optional parameters>]
    "
    exit 1
}

BEESPDESXAPP76=dev
BEESPDESXAPP77=dev
BEESPTESXAPP106=testqa
BEESPTESXAPP107=testqa
BEESPPESXAPP219=production
BEESPPESXAPP220=production

now=$(date +"%Y%m%d_%H%M")
port=
jar=
logDirectory=
hostname=`hostname`
environment="${!hostname}"
name=

# DEFAULT VALUES
EXTRA_OPTS=
JVM_ARGS="-server -Djava.net.preferIPv4Stack=true -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+AlwaysPreTouch -XX:ThreadStackSize=4096 -Xmx512m -Xms256m -XX:+PrintGCDetails -Xloggc:${logDirectory}/gc.log -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps"

realargs="$@"
while [ $# -gt 0 ]; do
    case "$1" in
        -j | --jar)
            jar=$2
            shift
        ;;
        -p | --port)
            port=$2
            shift
        ;;
        -l | --logDirectory)
            logDirectory=$2
            shift
        ;;
        -n | --name)
            name=$2
            shift
        ;;
        *)
            usage
        ;;
    esac
    shift
done
set -- $realargs

propertyFile="./properties/${environment}-${name}.properties"
if [ -f "$propertyFile" ]; then
    echo "Overriding defaults by $propertyFile"
    source "$propertyFile"
fi

echo "==============================="
echo "START"
echo "==============================="

if [ -z "$jar" ] || [ -z "$port" ] || [ -z "$logDirectory" ] || [ -z "$environment" ] || [ -z "$name" ]; then
    echo "[ABORTED] Mandatory fields are missing. Please check the usage."
    usage
    return
fi

if [ ! -f "/opt/shared/to_deploy/$jar" ]; then
    echo "UberJar does not exist. Build it with \"gradle shadowJar\" command and deploy."
    echo "Quited"
    exit 0
fi

pid=`ps ax | grep java | grep "ratpack" | grep "$name" | awk '{print $1}'`
if [ -n "$pid" ]; then
    kill -9 $pid
    echo "[STOP   ] Existing instance is killed [pid:$pid]"
else
    echo "[CHECK  ] No existing instance is found"
fi

pid=`ps ax | grep java | grep "ratpack" | grep "$name" | awk '{print $1}'`
if [ -n "$pid" ]; then
    echo "[ABORTED] Process [id:$pid] cannot be killed. Aborted."
    exit 1
fi

rm -Rf $logDirectory/*
echo "[CLEAN] Cleaned log folder $logDirectory"

mkdir -p "$logDirectory"
cmd="nohup /opt/java/bin/java $JVM_ARGS -Dratpack.port=$port -DlogDirectory=$logDirectory -Denvironment=$environment  -Dlogback.configurationFile=/opt/shared/devops/configuration/logs/${name}.groovy -Dname=$name ${EXTRA_OPTS} -jar /opt/shared/to_deploy/$jar > $logDirectory/stdout.log 2>&1&"
echo "[START  ] Service is starting with command [ $cmd ]"
bash -c "$cmd"
sleep 10
echo "[START  ] Service started"

mkdir -p "/opt/archive/packages/"
cp "/opt/shared/to_deploy/${jar}" "/opt/archive/packages/${now}-${jar}"
echo "[ARCHIVE] Package is archived to /opt/archive/packages/ directory"

pid=`ps ax | grep java | grep "ratpack" | grep "$name" | awk '{print $1}'`
if [ -z "$pid" ]; then
    echo "[ABORTED] Process seems missing. Aborted."
    exit 1
else
    echo "[DONE   ] Process [id:$pid] is started. Done."
fi

echo "==============================="

