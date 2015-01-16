#!/usr/bin/env bash

source settings 

echo "================= changing locale postgres =================="
sudo -u postgres pg_dumpall > /tmp/postgres.sql 
sudo -u postgres pg_dropcluster --stop 9.3 main
sudo -u postgres pg_createcluster --locale en_US.UTF-8 --start 9.3 main
sudo -u postgres psql -f /tmp/postgres.sql

# create root user
echo "================= creating root user =================="
sudo -u postgres createuser --superuser root
sudo -u postgres createdb root

# Edit the following to change the version of PostgreSQL that is installed
PG_VERSION=9.3

PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"

# Edit postgresql.conf to change listen address to '*':
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# Append to pg_hba.conf to add password auth:
sudo -u postgres echo "host    all             all             all                     md5" >> "$PG_HBA"

# Restart so that all new config is loaded:
sudo service postgresql restart

