#!/usr/bin/env bash

sudo supervisorctl stop dummy:*
sudo cp /home/vagrant/code/dist/supervisor_dummy_service_non_native.conf /etc/supervisor/conf.d/dummy.conf

sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start dummy:*