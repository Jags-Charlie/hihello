#!/usr/bin/env bash
sudo mkdir -p /var/jenkins_home
sudo chown -R 1000:1000 /var/jenkins_home
docker-compose up --build -d
