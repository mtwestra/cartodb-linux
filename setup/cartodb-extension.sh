#!/usr/bin/env bash

cd /usr/local/src/cartodb/lib/sql
sudo make all
sudo make install

#add cartodb to search_path in postgresql.conf
sudo sed -i "s/#search_path = '\"\$user\",public'/#search_path = '\"\$user\",public,cartodb'/" /etc/postgresql/9.3/main/postgresql.conf
sudo service postgresql reload