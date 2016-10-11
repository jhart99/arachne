FROM vogt1005.scripps.edu:5000/java8

# install zookeeperd
RUN curl http://apache.claz.org/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz  | \
    tar xvz

RUN mkdir /etc/zookeeper && \
    ln -s /usr/local/zookeeper-3.4.9/conf/ /etc/zookeeper/conf && \
    cp /etc/zookeeper/conf/zoo_sample.cfg /etc/zookeeper/conf/zoo.cfg && \
    find zookeeper-3.4.9/bin -name \*sh -exec ln -s '{}' /usr/local/bin \; && \
    ln -s /usr/local/zookeeper-3.4.9/ /usr/local/zookeeper && \
    mkdir -p /data/zookeeper

EXPOSE 2181 2888 3888
ADD files/zk.sh /usr/local/bin/zk.sh
ADD files/zoo.cfg /usr/local/zookeeper/conf/zoo.cfg
ADD files/zkServer.sh /usr/local/zookeeper/bin/zkServer.sh
CMD ["/usr/local/bin/zk.sh"]
