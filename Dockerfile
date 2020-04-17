FROM alpine:3.9
RUN apk update \
        && apk upgrade \
        && apk add --no-cache \
        ca-certificates \
        && update-ca-certificates 2>/dev/null || true \
        && apk add --no-cache speedtest-cli bash
RUN mkdir isp
ADD speedlog /speedlog
ADD crontab.txt /crontab.txt
RUN /usr/bin/crontab /crontab.txt
RUN touch /var/log/speedtest.log
CMD ["crond", "&&", "tail", "-f", "/var/log/speedtest.log"]
