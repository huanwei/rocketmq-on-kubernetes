FROM huanwei/rocketmq:4.3.2

ARG user=rocketmq
ARG group=rocketmq
ARG uid=3000
ARG gid=3000

# RocketMQ is run with user `rocketmq`, uid = 3000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN groupadd -g ${gid} ${group} \
    && useradd -u ${uid} -g ${gid} -m -s /bin/bash ${user}

RUN chown -R ${uid}:${gid} ${ROCKETMQ_HOME}

USER ${user}

WORKDIR ${ROCKETMQ_HOME}/bin