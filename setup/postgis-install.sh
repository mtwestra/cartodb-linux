#!/usr/bin/env bash

echo "================= downloading postgis =================="
cd /usr/local/src
sudo wget --quiet http://download.osgeo.org/postgis/source/postgis-2.1.2.tar.gz
sudo tar xzf postgis-2.1.2.tar.gz
cd postgis-2.1.2
echo "================= installing postgis =================="
sudo ./configure --with-raster --with-topology
sudo make
sudo make install

