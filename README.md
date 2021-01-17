# speedtest-docker

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/hvalev/isp-speedtest-docker/ci)
![Docker Pulls](https://img.shields.io/docker/pulls/hvalev/isp-speedtest)
![Docker Stars](https://img.shields.io/docker/stars/hvalev/isp-speedtest)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/hvalev/isp-speedtest)

Minimal docker container for testing your connection bandwidth using speedtest-cli and logging it to csv files organized by date as follows:</br>
2020-03-24.csv</br>
2020-03-25.csv</br>

## Usage
docker run
```
docker run -d --network host -e 'CRON_STRINGS=*/5 * * * * /speedtest.sh' -v /home/pi/isp-speedtest:/isp --name isp-speedtest hvalev/isp-speedtest
```

docker-compose
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

## Building
```
docker build https://github.com/hvalev/isp-speedtest-docker.git --tag isp-speedtest
```

## Acknowledgements 
Some code used from [here](https://github.com/igomez10/speedInspectorRPI/). Setting Cron strings as env variable approach used from [here](https://hub.docker.com/r/xordiv/docker-alpine-cron).

## Limitations
Bear in mind that speedtest-cli causes a lot of connections to spawn and if ran too frequently can slowly overwhelm your router! The default setting of 5 minutes should be okay. I hold no responsibility if you ~~d~~dos yourself. Limitations are also imposed by the speedtest-cli tool. A detailed list of those for further reading can be found [here](https://github.com/sivel/speedtest-cli#inconsistency).
