#!/bin/bash

# Stop and remove existed containers if any
docker rm -f $(docker ps -a|awk '/huanwei\/rocketmq/ {print $1}')

# Run namesrv and broker
docker run -d -p 9876:9876 -v `pwd`/data/namesrv/logs:/root/logs/rocketmqlogs  --name rmqnamesrv  huanwei/rocketmq:4.3.2 sh mqnamesrv
docker run -d -p 10911:10911 -p 10909:10909 -v `pwd`/data/broker/logs:/root/logs/rocketmqlogs/ -v `pwd`/data/broker/store:/root/store --name rmqbroker --link rmqnamesrv:namesrv -e "NAMESRV_ADDR=namesrv:9876" huanwei/rocketmq:4.3.2 sh mqbroker


# Verify
# docker exec -it 9611e7a92f6b ./mqadmin clusterList -n 10.10.103.182:9876

#  kubectl exec -it rocketmq-6cbbb8d9fb-z7ljw bash
#  ./mqadmin clusterList -n localhost:9876

# run without hostpath
#docker run -d -p 9876:9876  --name rmqnamesrv  huanwei/rocketmq:4.3.2 sh mqnamesrv
#docker run -d -p 10911:10911 -p 10909:10909 --name rmqbroker --link rmqnamesrv:namesrv -e "NAMESRV_ADDR=namesrv:9876" huanwei/rocketmq:4.3.2 sh mqbroker


# refer
#https://github.com/huanwei/rocketmq-externals/tree/a717082cb572ef4afbfdef9be8f1262b94de426a/rocketmq-docker
#https://github.com/huanwei/rocketmq-externals/commit/a69ccd407d089d12c663c12f3c1d9ff6fc279f1f