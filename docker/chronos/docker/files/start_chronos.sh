#!/bin/bash
echo "setting locale"
locale-gen en_US.UTF-8 > /dev/null 2>&1
echo "starting syslog"
service rsyslog start > /dev/null 2>&1

cat $ZK_LIST > /etc/chronos/conf/master
cat $ZK_LIST > /etc/chronos/conf/zk_hosts
echo 8080 > /etc/chronos/conf/http_port

MESOS_NATIVE_LIBRARY="/usr/local/lib/libmesos.so"
MESOS_LAUNCHER_DIR="/usr/bin"
JAVA_LIBRARY_PATH="/usr/local/lib:/lib:/usr/lib"
LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:-/lib}"
LD_LIBRARY_PATH="$JAVA_LIBRARY_PATH:$LD_LIBRARY_PATH"

# wait for the DNS to be set
until ping -c 1 chronos-${CHRONOS_ID}.sky.vogt.local; do
    echo "chronos still not resolved"
    sleep 1
done
echo "chronos resolved. continuing startup"

chronos run_jar --hostname chronos.sky.vogt.local --master $ZK_LIST --zk_hosts $ZK_LIST --http_port 8080
