FROM alpine:20201218 

RUN apk update && apk add --no-cache \
    dcron curl wget rsync ca-certificates speedtest-cli bash && \ 
    rm -rf /var/cache/apk/*

COPY /scripts/* /

RUN mkdir -m 0644 -p /var/spool/cron/crontabs && \
    mkdir -p /var/log/cron && \
    touch /var/log/cron/cron.log && \
    mkdir -m 0644 -p /etc/cron.d && \
    mkdir isp && \
    chmod +x /speedtest.sh

ENTRYPOINT ["/docker-entry.sh"]
CMD ["/docker-cmd.sh"]