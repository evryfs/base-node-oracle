FROM node:14.17.6-buster-slim
# hadolint ignore=DL3008
ARG INSTANT_CLIENT=https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basiclite-linux.x64-21.1.0.0.0.zip
ARG INSTANT_CLIENT_LOCATION=/opt/oracle/instantclient_21_1
# hadolint ignore=DL3008
RUN apt-get update && \
  apt-get -y --no-install-recommends install libaio1 curl ca-certificates unzip && \
  mkdir /opt/oracle && \
  curl -L ${INSTANT_CLIENT} -o /tmp/instantclient.zip && \
  unzip /tmp/instantclient.zip -d /opt/oracle && \
  chown -R node:node ${INSTANT_CLIENT_LOCATION} && \
  echo ${INSTANT_CLIENT_LOCATION} > /etc/ld.so.conf.d/oracle-instantclient.conf && \
  ldconfig && \
  apt-get -y clean && \
  rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
