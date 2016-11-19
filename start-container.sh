#!/bin/bash

# the default node number is 3
N=${2:-3}


# start master container
docker rm -f master &> /dev/null
echo "start master container..."
docker run -itd \
           --net=hadoop \
           -v $1:/root/jars \
           -p 4040:4040 \
           -p 8080:8080 \
           -p 50070:50070 \
           -p 8088:8088 \
           --name hadoop-master \
           --hostname hadoop-master \
           miaolegemitong/spark:1.0 &> /dev/null


# start slave container
i=1
while [ $i -lt $N ]
do
	docker rm -f slave$i &> /dev/null
	echo "start slave$i container..."
	docker run -itd \
	           --net=hadoop \
	           --name hadoop-slave$i \
	           --hostname hadoop-slave$i \
	           miaolegemitong/spark:1.0 &> /dev/null
	i=$(( $i + 1 ))
done 

# get into hadoop master container
docker exec -it hadoop-master bash
