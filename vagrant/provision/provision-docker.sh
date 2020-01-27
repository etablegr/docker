#!/usr/bin/env bash

echo "Removing volumes in order not to cause a confusion"
sudo docker-compose -f /home/vagrant/code/docker-compose.yml down -v

echo "Launch App"
sudo docker-compose -f /home/vagrant/code/docker-compose.yml up -d

