# Why is this coming from Ubuntu 15.04?  Because Mesos Slave requires systemd
# >= 218 and I couldn't get that to happen with debian.
FROM vogt1005.scripps.edu:5000/java7

WORKDIR /usr/local

# install mesos
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    echo "deb http://repos.mesosphere.io/debian jessie main" | \
    tee /etc/apt/sources.list.d/mesosphere.list && \
    apt-get -y update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get --no-install-recommends install -y mesos net-tools && \
    rm -rf /var/lib/apt/lists/*
