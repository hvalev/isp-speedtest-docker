FROM alpine:latest 
RUN apk update && apk add dcron curl wget rsync ca-certificates && rm -rf /var/cache/apk/*
RUN mkdir -p /var/log/cron && mkdir -m 0644 -p /var/spool/cron/crontabs && touch /var/log/cron/cron.log && mkdir -m 0644 -p /etc/cron.d
RUN apk add --no-cache speedtest-cli bash
COPY /scripts/* /
RUN mkdir isp
RUN chmod 777 /speedtest.sh
ENTRYPOINT ["/docker-entry.sh"]
CMD ["/docker-cmd.sh"]