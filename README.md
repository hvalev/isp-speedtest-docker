# speedtest-docker
![](https://github.com/hvalev/isp-speedtest-docker/workflows/.github/workflows/main.yml/badge.svg)
Minimal speedtest docker container using speedtest-cli for logging your ISP speed to csv files separated by date as such:</br>
2020-03-24.csv</br>
2020-03-25.csv</br>

For limitations of the speedtest-cli tool see here: https://github.com/sivel/speedtest-cli#inconsistency</br>
Some code borrowed from here: https://github.com/igomez10/speedInspectorRPI/</br>

To get it running you can either use: </br>
* docker run command
```
docker build https://github.com/hvalev/isp-speedtest-docker.git --tag isp-speedtest
docker run -d --network host -v /home/pi/isp-logs/:/isp/ --name isp-speedtest isp-speedtest
```

* docker-compose file
```
version: "3.7"
services:
  isp-speedtest:
    container_name: isp-speedtest
    build: https://github.com/hvalev/isp-speedtest-docker.git
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Amsterdam
    volumes:
      - /home/pi/isp-logs/:/isp/
    restart: always
```
