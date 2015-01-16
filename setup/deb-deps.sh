#!/usr/bin/env bash
# This takes care of installing dependencies required from debian repos.

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

apt-get update

apt-get install -y python-software-properties

# new
#apt-get install nodejs
#sudo add-apt-repository ppa:cartodb/nodejs-010
#sudo apt-get update; sudo apt-get upgrade
#sudo apt-get dist-upgrade
# end new

echo "================= getting repositories =================="
add-apt-repository -y ppa:cartodb/base
add-apt-repository -y ppa:cartodb/gis
add-apt-repository -y ppa:mapnik/v2.1.0
add-apt-repository -y ppa:cartodb/nodejs-010
add-apt-repository -y ppa:cartodb/redis
add-apt-repository -y ppa:cartodb/postgresql-9.3
add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable

echo "================= apt-get update =================="
apt-get update

echo "================= apt-get install =================="
apt-get install -y make unp zip libgeos-c1 libgeos-dev gdal-bin libgdal1-dev libjson0 \
  python-simplejson libjson0-dev proj-bin proj-data libproj-dev postgresql-9.3 \
  postgresql-client-9.3 postgresql-contrib-9.3 postgresql-server-dev-9.3 \
  postgresql-plpython-9.3 ruby1.9.1 ruby1.9.1-dev nodejs redis-server libmapnik-dev \
  mapnik-utils python-mapnik git python-setuptools python-gdal gdal-bin libgdal1-dev \
  mercurial

