# speedtest-docker
![](https://github.com/hvalev/isp-speedtest-docker/workflows/.github/workflows/main.yml/badge.svg)
Minimal speedtest docker container using speedtest-cli for logging your ISP speed to csv files organized by date as follows:</br>
2020-03-24.csv</br>
2020-03-25.csv</br>

For limitations of the speedtest-cli tool see here: https://github.com/sivel/speedtest-cli#inconsistency</br>
Some code used from here: https://github.com/igomez10/speedInspectorRPI/</br>
Cron setting as env variable approach used from here: https://hub.docker.com/r/xordiv/docker-alpine-cron (docker image is only available for amd64)</br>

Bear in mind that speedtest-cli causes a lot of connections to spawn and if ran too frequently can slowly overwhelm your router! The default setting of 5 minutes should be okay. I hold no responsibility if you ldos yourself as I did multiple times.

To get it running you can either use: </br>
* docker run command
```
docker build https://github.com/hvalev/isp-speedtest-docker.git --tag isp-speedtest
docker run -d --network host -e 'CRON_STRINGS=*/5 * * * * /speedtest.sh' -v /home/pi/isp-speedtest:/isp --name isp-speedtest isp-speedtest
```

* docker-compose file
```
version: "3.7"
services:
  isp-speedtest:
    image: hvalev/isp-speedtest
    container_name: isp-speedtest
    network_mode: host
    environment:
      - 'CRON_STRINGS=*/5 * * * * /speedtest.sh'
    volumes:
      - /home/pi/isp-speedtest/:/isp/
    restart: always
```
