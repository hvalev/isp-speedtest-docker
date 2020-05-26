FROM alpine:latest
RUN apk update
RUN apk upgrade 
RUN apk add --no-cache ca-certificates
RUN update-ca-certificates 2>/dev/null || true
RUN apk add --no-cache speedtest-cli bash
RUN mkdir isp
ADD speedlog /speedlog
RUN chmod 777 speedlog
ADD crontab.txt /crontab.txt
RUN /usr/bin/crontab /crontab.txt
RUN touch /isp/speedtest.log
RUN chmod 777 /isp/speedtest.log
RUN ln -s /usr/bin/python3 /usr/bin/python
CMD ["crond", "&&", "tail", "-f", "/var/log/speedtest.log"]
