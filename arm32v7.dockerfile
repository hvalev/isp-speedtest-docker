FROM alpine AS builder

# Download QEMU, see https://github.com/docker/hub-feedback/issues/1261
ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-arm.tar.gz
RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1

FROM arm32v7/alpine:3.11

# Add QEMU
COPY --from=builder qemu-arm-static /usr/bin

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
