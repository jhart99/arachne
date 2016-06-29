FROM vogt1005.scripps.edu:5000/java7

# install zookeeperd
RUN curl http://apache.claz.org/zookeeper/zookeeper-3.5.1-alpha/zookeeper-3.5.1-alpha.tar.gz  | \
    tar xvz

RUN mkdir /etc/zookeeper && \
    ln -s /usr/local/zookeeper-3.5.1-alpha/conf/ /etc/zookeeper/conf && \
    cp /etc/zookeeper/conf/zoo_sample.cfg /etc/zookeeper/conf/zoo.cfg && \
    find zookeeper-3.5.1-alpha/bin -name \*sh -exec ln -s '{}' /usr/local/bin \; && \
    ln -s /usr/local/zookeeper-3.5.1-alpha/ /usr/local/zookeeper && \
    mkdir -p /data/zookeeper

EXPOSE 2181 2888 3888
ADD files/zk.sh /usr/local/bin/zk.sh
ADD files/zoo.cfg /usr/local/zookeeper/conf/zoo.cfg
CMD ["/usr/local/bin/zk.sh"]
