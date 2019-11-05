#!/bin/bash

# Build rocketmq
docker build -t huanwei/rocketmq:4.3.2-rootless --build-arg version=4.3.2 ./rocketmq