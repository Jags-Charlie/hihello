#!/usr/bin/env bash

# sonar-installation.sh
sudo sysctl vm.max_map_count=262144
sudo docker-compose up -d
# default password admin => admin
# update password admin => sonar
