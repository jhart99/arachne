FROM vogt1005.scripps.edu:5000/ldap

WORKDIR /usr/local

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get -y --no-install-recommends install curl tzdata tzdata-java \
       libpython-stdlib libpython2.7-minimal libpython2.7-stdlib \
       lsb-release mime-support python python-minimal python2.7 python2.7-minimal && \
    echo "deb http://ftp.debian.org/debian stretch main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get -y --no-install-recommends install -t stretch openjdk-8-jre-headless ca-certificates-java && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV JAVA /usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/java

STOPSIGNAL SIGRTMIN+3
