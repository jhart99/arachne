.PHONY: all release java8 mesos mesos-master mesos-agent hadoop hdfs-datanode hdfs-namenode chronos zk

subdirs = java8 mesos mesos-master mesos-agent hadoop hdfs-datanode hdfs-namenode chronos zk spark spark-rstudio python2.7 ipxeman

all: $(subdirs)

java8:
mesos: java8
mesos-master: mesos
mesos-agent: mesos
#hadoop: java8
#hdfs-datanode: hadoop
#hdfs-namenode: hadoop
chronos: mesos
zk: java8
rsem:
spark: java8
spark-rstudio: java8
python2.7:
ipxeman: python2.7

${subdirs}:
	${MAKE} -C $@ $(OPTS)
	touch $@

release: OPTS = release
release: all

clean:
	find . -name release -exec rm '{}' \;
	find . -name build -exec rm '{}' \;

