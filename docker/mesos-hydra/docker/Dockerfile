FROM debian:jessie

WORKDIR /usr/local

# install zookeeperd
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get -y --no-install-recommends install openjdk-7-jre-headless curl tzdata tzdata-java \
       libpython-stdlib libpython2.7-minimal libpython2.7-stdlib \
       lsb-release mime-support python python-minimal python2.7 python2.7-minimal && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-amd64
ENV JAVA /usr/lib/jvm/java-1.7.0-openjdk-amd64/bin/java
