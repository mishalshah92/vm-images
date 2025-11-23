#!/bin/bash

set -e
set -x

# Testing docker
docker info
cat /etc/docker/daemon.json || true
docker images

# Testing docker-compose
docker-compose version

# Azure CLI test
az version

# Print Cloud-init
cat /etc/waagent.conf

# Check telegraf
#sudo systemctl --no-pager status telegraf

# Check Vanta Status
# sudo /var/vanta/vanta-cli status
# sudo /var/vanta/vanta-cli doctor

java -version

echo $?
