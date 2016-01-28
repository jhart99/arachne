#!/bin/bash

# Output server ID
echo "server id (myid): ${ZK_ID}"
# wait until our name is resolvable to bypass some java name resolution issues.
until ping -c 1 zk-${ZK_ID}.sky.vogt.local; do
    echo "zk-${ZK_ID} still not resolved"
    sleep 1
done
echo "zk-${ZK_ID} resolved. continuing startup"

mkdir /tmp/zookeeper
echo "${ZK_ID}" > /data/zookeeper/myid

for i in $(seq 1 $ZK_N); do
    echo server.$i=zk-${i}.sky.vogt.local:2888:3888 >> /usr/local/zookeeper/conf/zoo.cfg
done
echo "info: starting zookeeper"

cat /usr/local/zookeeper/conf/zoo.cfg

/usr/local/zookeeper/bin/zkServer.sh start-foreground
