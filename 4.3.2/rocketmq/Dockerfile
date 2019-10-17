FROM centos:7

RUN yum install -y java-1.8.0-openjdk-headless unzip gettext nmap-ncat openssl\
 && yum clean all -y

ARG version

# Rocketmq version
ENV ROCKETMQ_VERSION ${version}

# Rocketmq home
ENV ROCKETMQ_HOME  /opt/rocketmq-${ROCKETMQ_VERSION}

WORKDIR  ${ROCKETMQ_HOME}

# get the version
RUN curl https://dist.apache.org/repos/dist/release/rocketmq/${ROCKETMQ_VERSION}/rocketmq-all-${ROCKETMQ_VERSION}-bin-release.zip -o rocketmq.zip \
 && unzip rocketmq.zip \
 && mv rocketmq-all*/* . \
 && rmdir rocketmq-all*  \
 && rm rocketmq.zip

# add scripts
COPY scripts ${ROCKETMQ_HOME}/bin/

# expose namesrv port
EXPOSE 9876

# add customized scripts for namesrv
RUN mv ${ROCKETMQ_HOME}/bin/runserver-customize.sh ${ROCKETMQ_HOME}/bin/runserver.sh \
 && chmod +x ${ROCKETMQ_HOME}/bin/runserver.sh \
 && chmod +x ${ROCKETMQ_HOME}/bin/mqnamesrv

# expose broker ports
EXPOSE 10909 10911

# add customized scripts for broker
RUN mv ${ROCKETMQ_HOME}/bin/runbroker-customize.sh ${ROCKETMQ_HOME}/bin/runbroker.sh \
 && chmod +x ${ROCKETMQ_HOME}/bin/runbroker.sh \
 && chmod +x ${ROCKETMQ_HOME}/bin/mqbroker

# export Java options
RUN export JAVA_OPT=" -Duser.home=/opt"

WORKDIR ${ROCKETMQ_HOME}/bin