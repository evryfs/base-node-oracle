FROM node:14.10.0-buster-slim
# hadolint ignore=DL3008
RUN apt-get update && \
  apt-get -y --no-install-recommends install libaio1 curl ca-certificates unzip && \
  mkdir /opt/oracle && \
  curl -L https://download.oracle.com/otn_software/linux/instantclient/19600/instantclient-basiclite-linux.x64-19.6.0.0.0dbru.zip -o /tmp/instantclient.zip && \
  unzip /tmp/instantclient.zip -d /opt/oracle && \
  chown -R node:node /opt/oracle/instantclient_19_6/ && \
  echo /opt/oracle/instantclient_19_6 > /etc/ld.so.conf.d/oracle-instantclient.conf && \
  ldconfig && \
  apt-get -y clean && \
  rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
