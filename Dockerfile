FROM kiwenlau/hadoop:1.0

MAINTAINER miaolegemitong <mitong1993@gmail.com>

WORKDIR /root

COPY config/* /tmp/

# set hadoop and yarn conf dir
ENV HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR=/usr/local/hadoop/etc/hadoop

# install scala
RUN wget http://downloads.lightbend.com/scala/2.12.0/scala-2.12.0.tgz && \
    tar zxvf scala-2.12.0.tgz && \
    mv scala-2.12.0 /usr/local/scala && \
    rm scala-2.12.0.tgz
ENV SCALA_HOME=/usr/local/scala
ENV PATH=$SCALA_HOME/bin:$PATH

# install spark
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.1-bin-hadoop2.7.tgz && \
    tar zxvf spark-2.0.1-bin-hadoop2.7.tgz && \
    mv spark-2.0.1-bin-hadoop2.7 /usr/local/spark && \
    rm spark-2.0.1-bin-hadoop2.7.tgz
ENV SPARK_HOME=/usr/local/spark
ENV PATH=$SPARK_HOME/bin:$PATH

RUN mv /tmp/hadoop-slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/spark-slaves $SPARK_HOME/conf/slaves && \
    mv /tmp/spark-env.sh $SPARK_HOME/conf/spark-env.sh && \
    mv /tmp/start-spark.sh /root/start-spark.sh

RUN chmod +x /root/start-spark.sh && \
    chmod +x /usr/local/spark/sbin/start-all.sh

CMD [ "sh", "-c", "service ssh start; bash"]
