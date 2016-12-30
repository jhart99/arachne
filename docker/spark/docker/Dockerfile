FROM vogt1005.scripps.edu:5000/mesos
WORKDIR /usr/local

ENV DEBIAN_FRONTEND noninteractive
RUN curl http://apache.mirrors.tds.net/spark/spark-2.0.1/spark-2.0.1-bin-hadoop2.7.tgz | \
    tar xvz && \
    ln -s spark-2.0.1-bin-hadoop2.7 spark

ENV SPARK_HOME /usr/local/spark
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/local/lib/libmesos.so

ADD files/spark-defaults.conf /usr/local/spark/conf
