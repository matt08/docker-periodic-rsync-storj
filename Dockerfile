# Storj Backup Servers

FROM alpine:latest

# install packages
RUN apk update -qq \
 && apk add \
    rsync \
    openssh-client \
    tar \
    wget \
    curl \
    unzip \
    bash \
 && rm  -rf /tmp/* /var/cache/apk/*

# remove default cron jobs
RUN rm -f /etc/cron.*/*

RUN curl -L https://github.com/storj/storj/releases/latest/download/uplink_linux_amd64.zip -o uplink_linux_amd64.zip \
 && unzip -o uplink_linux_amd64.zip \
 && install uplink /usr/local/bin/uplink

# expose
#VOLUME /var/spool/cron/crontabs
#VOLUME /root/.ssh
#VOLUME /data
#VOLUME /root/.config/storj

CMD ["/usr/sbin/crond","-f","-l","2"]