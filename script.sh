#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \ "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu/ $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version
echo 'version: "2"' > docker-compose.yml
echo "networks:" >> docker-compose.yml
echo "  splunknet:" >> docker-compose.yml
echo "    driver: bridge" >> docker-compose.yml
echo " " >> docker-compose.yml
echo "volumes:" >> docker-compose.yml
echo "  splunk-data: {}" >> docker-compose.yml
echo " " >> docker-compose.yml
echo "services:" >> docker-compose.yml
echo "  splunk:" >> docker-compose.yml
echo "    networks:" >> docker-compose.yml
echo "      splunknet:" >> docker-compose.yml
echo "        aliases:" >> docker-compose.yml
echo "         - splunk" >> docker-compose.yml
echo "    image: splunk/splunk" >> docker-compose.yml
echo "    restart: always" >> docker-compose.yml
echo "    container_name: splunk" >> docker-compose.yml
echo "    environment:" >> docker-compose.yml
echo "      - SPLUNK_START_ARGS=--accept-license" >> docker-compose.yml
echo "      - SPLUNK_PASSWORD=diogenes2022" >> docker-compose.yml
echo "      - DEBUG=true" >> docker-compose.yml
echo "    ports:" >> docker-compose.yml
echo "      - 8083:8000" >> docker-compose.yml
echo "      - 8084:8089" >> docker-compose.yml
echo "    volumes:" >> docker-compose.yml
echo "      - splunk-data:/opt/splunk" >> docker-compose.yml
docker-compose up -d

docker ps
