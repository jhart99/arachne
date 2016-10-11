#!/bin/bash

# Set locale: this is required by the standard Mesos startup scripts
echo "info: Setting locale to en_US.UTF-8..."
locale-gen en_US.UTF-8 > /dev/null 2>&1

# Start syslog if not started....
echo "info: Starting syslog..."
service rsyslog start > /dev/null 2>&1

function start_master {
  echo in_memory > /etc/mesos/registry
  echo $ZK_LIST > /etc/mesos/zk
  echo /var/log/mesos > /etc/mesos-master/log_dir
  echo 3 > /etc/mesos-master/quorum
  echo mesos-master-${MESOS_MASTER_ID}.sky.vogt.local > /etc/mesos-master/hostname
  echo 'ULIMIT="-n 8192"' > /etc/default/mesos

  echo networkaddress.cache=0 >> $JAVA_HOME/jre/lib/security/java.security
  echo networkaddress.cachenegative=0 >> $JAVA_HOME/jre/lib/security/java.security
  set -e
  echo "info: Starting Mesos master..."
  /usr/bin/mesos-init-wrapper master &

  # wait for the master to start
  sleep 1 && while [[ -z $(netstat -lnt | awk "\$6 == \"LISTEN\" && \$4 ~ \".5050\" && \$1 ~ tcp") ]] ; do
      echo "info: Waiting for Mesos master to come online..."
      sleep 3;
  done
  echo "info: Mesos master started on port 5050"
}
  start_master
  sleep 10
  tail  -f /var/log/mesos/mesos-master.INFO
wait
