.PHONY: all release java7 mesos mesos-master mesos-slave hadoop hdfs-datanode hdfs-namenode chronos zk

subdirs = java7 mesos mesos-master mesos-slave hadoop hdfs-datanode hdfs-namenode chronos zk

all: $(subdirs)

java7:
mesos: java7
mesos-master: mesos
mesos-slave: mesos
hadoop: java7
hdfs-datanode: hadoop
hdfs-namenode: hadoop
chronos: mesos
zk: java7

${subdirs}:
	${MAKE} -C $@ $(OPTS)
	touch $@

release: OPTS = release
release: all

clean: OPTS = clean
clean: all


