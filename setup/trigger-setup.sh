#!/usr/bin/env bash

cd /usr/local/src

sudo hg clone https://bitbucket.org/malloclabs/pg_schema_triggers
cd pg_schema_triggers
sudo make
sudo make install

# update postgresql.conf
echo "shared_preload_libraries = 'schema_triggers.so'" | sudo tee -a /etc/postgresql/9.3/main/postgresql.conf
sudo service postgresql restart