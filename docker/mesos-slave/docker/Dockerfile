FROM vogt1005.scripps.edu:5000/mesos

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get -y --no-install-recommends install apt-transport-https && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get -y --no-install-recommends install docker-engine=1.8.3-0~jessie && \
    ln -sf /usr/bin/docker.io /usr/local/bin/docker && \
    rm -rf /var/lib/apt/lists/*


ADD files/slave.sh /usr/local/bin
CMD slave.sh
