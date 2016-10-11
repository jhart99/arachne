.PHONY: all release java8 mesos mesos-master mesos-agent hadoop hdfs-datanode hdfs-namenode chronos zk

subdirs = java8 mesos mesos-master mesos-agent hadoop hdfs-datanode hdfs-namenode chronos zk

all: $(subdirs)

java8:
mesos: java8
mesos-master: mesos
mesos-agent: mesos
hadoop: java8
hdfs-datanode: hadoop
hdfs-namenode: hadoop
chronos: mesos
zk: java8
rsem:

${subdirs}:
	${MAKE} -C $@ $(OPTS)
	touch $@

release: OPTS = release
release: all

clean:
	find . -name release -exec rm '{}' \;
	find . -name build -exec rm '{}' \;

