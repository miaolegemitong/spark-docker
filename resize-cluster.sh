#!/bin/bash

# N is the node number of hadoop cluster
N=$1

if [ $# = 0 ]
then
	echo "Please specify the node number of spark cluster!"
	exit 1
fi

# change slaves file
i=1
rm config/hadoop-slaves
rm config/spark-slaves
echo "hadoop-master" > config/spark-slaves
while [ $i -lt $N ]
do
	echo "hadoop-slave$i" >> config/spark-slaves
	echo "hadoop-slave$i" >> config/hadoop-slaves
	((i++))
done 

echo ""

echo -e "\nbuild docker hadoop image\n"

# rebuild kiwenlau/hadoop image
docker build -t miaolegemitong/spark:1.0 .

echo ""
