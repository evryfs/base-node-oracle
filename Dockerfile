FROM node:12.18.4-buster-slim
# hadolint ignore=DL3008
ARG INSTANT_CLIENT=https://download.oracle.com/otn_software/linux/instantclient/19800/instantclient-basiclite-linux.x64-19.8.0.0.0dbru.zip
RUN apt-get update && \
  apt-get -y --no-install-recommends install libaio1 curl ca-certificates unzip && \
  mkdir /opt/oracle && \
  curl -L ${INSTANT_CLIENT} -o /tmp/instantclient.zip && \
  unzip /tmp/instantclient.zip -d /opt/oracle && \
  chown -R node:node /opt/oracle/instantclient_19_8/ && \
  echo /opt/oracle/instantclient_19_6 > /etc/ld.so.conf.d/oracle-instantclient.conf && \
  ldconfig && \
  apt-get -y clean && \
  rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
