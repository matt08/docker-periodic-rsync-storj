# docker-periodic-rsync-storj

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

RUN curl -L https://github.com/storj/storj/releases/latest/download/uplink_linux_amd64.zip -o uplink_linux_amd64.zip \
 && unzip -o uplink_linux_amd64.zip \
 && install uplink /usr/local/bin/uplink

RUN rm -f /var/spool/cron/crontabs && \ 
    mkdir /var/spool/cron/crontabs && \
    [ ! -f /var/spool/cron/crontabs/root ] && printf '%s\n' '# min	hour	day	month	weekday	command' '00	2	*	*	*	bash /data/backup.sh  > /dev/null 2>&1' > /var/spool/cron/crontabs/root

# expose
#VOLUME /var/spool/cron/crontabs/
#VOLUME /root/.ssh
#VOLUME /data
#VOLUME /root/.config/storj

CMD ["crond","-f"]
