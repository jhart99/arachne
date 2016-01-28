FROM vogt1005.scripps.edu:5000/java7

WORKDIR /usr/local
RUN curl http://apachemirror.ovidiudan.com/hadoop/common/hadoop-2.6.3/hadoop-2.6.3.tar.gz | tar xvz && \
    ln -s hadoop-2.6.3 hadoop

RUN echo "deb http://http.us.debian.org/debian/ testing non-free contrib main " >> /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get -t testing install -y libc6 && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-amd64
ENV JAVA /usr/lib/jvm/java-1.7.0-openjdk-amd64/bin/java
ENV HADOOP_INSTALL /usr/local/hadoop
ENV PATH $PATH:$HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin
ENV HADOOP_HOME $HADOOP_INSTALL
ENV HADOOP_MAPRED_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_HOME $HADOOP_INSTALL
ENV HADOOP_HDFS_HOME $HADOOP_INSTALL
ENV HADOOP_YARN_HOME $HADOOP_INSTALL
ENV HADOOP_CONF_DIR $HADOOP_INSTALL/etc/hadoop

ADD files/core-site.xml $HADOOP_CONF_DIR
ADD files/hdfs-site.xml $HADOOP_CONF_DIR
