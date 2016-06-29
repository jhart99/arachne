#!/bin/bash

# Set locale: this is required by the standard Mesos startup scripts
echo "info: Setting locale to en_US.UTF-8..."
# echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
# echo 'LANG="en_US.UTF-8"' > /etc/default/locale
# dpkg-reconfigure --frontend=noninteractive locales
# update-locale LANG=en_US.UTF-8
locale-gen en_US.UTF-8

# Start syslog if not started....
echo "info: Starting syslog..."
service rsyslog start > /dev/null 2>&1

function start_slave {
  echo "info: Mesos slave will try to register with a master using ZooKeeper"
  echo "info: Starting slave..."

  echo $ZK_LIST > /etc/mesos/zk
  echo /var/lib/mesos > /etc/mesos-slave/work_dir
  echo 'docker,mesos' > /etc/mesos-slave/containerizers
  echo '5mins' > /etc/mesos-slave/executor_registration_timeout
  echo mesos-slave-${MESOS_SLAVE_ID}.sky.vogt.local > /etc/mesos-slave/hostname
  echo 'posix' > /etc/mesos-slave/launcher
  echo 'false' > /etc/mesos-slave/systemd_enable_support
  echo 'ULIMIT="-n 8192"' > /etc/default/mesos

  # Wait for the hostname to resolve
  until ping -c 1 mesos-slave-${MESOS_SLAVE_ID}.sky.vogt.local; do
      echo "mesos-slave-${MESOS_SLAVE_ID} still not resolved"
      sleep 1
  done
  /usr/bin/mesos-init-wrapper slave --no-logger &


  # wait for the slave to start
  sleep 1 && while [[ -z $(netstat -lnt | awk "\$6 == \"LISTEN\" && \$4 ~ \".5051\" && \$1 ~ tcp") ]] ; do
  echo "info: Waiting for Mesos slave to come online..."
  sleep 3;
  done
  echo "info: Mesos slave started on port 5051"
}
start_slave
wait
