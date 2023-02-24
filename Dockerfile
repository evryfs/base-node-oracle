FROM node:18.14.2-bullseye-slim
# hadolint ignore=DL3008
ARG INSTANT_CLIENT=https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip
ARG INSTANT_CLIENT_LOCATION=/opt/oracle/instantclient
# hadolint ignore=DL3008
RUN apt-get update && \
  apt-get -y --no-install-recommends install libaio1 curl ca-certificates unzip && \
  mkdir /opt/oracle && \
  curl -L ${INSTANT_CLIENT} -o /tmp/instantclient.zip && \
  unzip /tmp/instantclient.zip -d /opt/oracle && \
  mv /opt/oracle/instant* ${INSTANT_CLIENT_LOCATION} && \
  rm /tmp/*.zip && \
  chown -R node:node ${INSTANT_CLIENT_LOCATION} && \
  echo ${INSTANT_CLIENT_LOCATION} > /etc/ld.so.conf.d/oracle-instantclient.conf && \
  ldconfig && \
  apt-get -y clean && \
  rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
