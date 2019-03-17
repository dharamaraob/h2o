#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install nginx
sudo yum update -y
wget http://h2o-release.s3.amazonaws.com/h2o/rel-xu/6/h2o-3.22.1.6.zip
unzip h2o-3.22.1.6.zip
cd h2o-3.22.1.6
java -jar h2o.jar &
