## 在Docker中运行Hadoop+Spark集群

##### 本镜像基于kiwenlau/hadoop:1.0构建，hadoop配置请参考https://github.com/kiwenlau/hadoop-cluster-docker

### 3节点集群
##### 1、拉取Docker镜像

```
docker pull miaolegemitong/spark:1.0
```

##### 2、克隆git仓库

```
git clone git@github.com:miaolegemitong/spark-docker.git
```

##### 3. 创建网络

```
sudo docker network create --driver=bridge hadoop
```

#####4. 启动容器，需要把放jar包的路径作为第一个参数传递，之后这个路径会被挂载到master容器的/root/jars目录

```
cd spark-docker
sudo ./start-container.sh <your jars path>
```

**output:**

```
start master container...
start slave1 container...
start slave2 container...
root@hadoop-master:~# 
```
- 启动了1个master、2个slave的hadoop集群
- 启动了1个master、3个slave(master机器也作为slave使用）的Spark集群
- 之后进入hadoop-master容器的/root目录

#####5. 启动Hadoop

```
./start-hadoop.sh
```

#####6. 运行Hadoop word count

```
./run-wordcount.sh
```

**output**

```
input file1.txt:
Hello Hadoop

input file2.txt:
Hello Docker

wordcount output:
Docker    1
Hadoop    1
Hello    2
```

##### 7、启动Spark

```
./start-spark.sh
```

### 任意个数节点的集群

#####1. 拉取docker镜像，克隆git仓库

重复3节点集群中的1-3步

#####2. 重新build docker镜像

```
./resize-cluster.sh 5
```
- 指定大于3的参数
- 脚本将重写不同的**slaves**文件


#####3. 启动容器

```
sudo ./start-container.sh <your jars path> 5
```
- 使用和第2步相同的参数

#####4. 启动Hadoop和Spark集群 

和3节点中第5-7步一致
