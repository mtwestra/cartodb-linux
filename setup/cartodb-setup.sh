#!/usr/bin/env bash
source settings

# get postgres to drop all security
#mv /etc/postgresql/9.3/main/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf.original
#ln -s /usr/local/etc/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

# change all md5 or peer permissions to trust.
# Replaces even commented out lines which isn't ideal...
cd /etc/postgresql/9.3/main
sudo perl -i.bak -p -e's/(md5|peer)$/trust/g' pg_hba.conf
echo "=========================== reloading postgres =================================="
sudo service postgresql reload

# make sure redis-server is running. If it is not running, start it in the background.
pgrep redis-server || redis-server &

# The included config files are way out of date and will cause you very much pain
#ln -s /usr/local/etc/cartodb.development.js /usr/local/src/CartoDB-SQL-API/config/environments/development.js
#ln -s /usr/local/etc/windshaft.development.js /usr/local/src/Windshaft-cartodb/config/environments/development.js
# Instead, just patch the current ones:
cd /usr/local/src/
cp CartoDB-SQL-API/config/environments/development.js.example CartoDB-SQL-API/config/environments/development.js
perl -p -i -e 's/^(module.exports.node_host).*$/\1 = '"''/g" /usr/local/src/CartoDB-SQL-API/config/environments/development.js

cp Windshaft-cartodb/config/environments/development.js.example Windshaft-cartodb/config/environments/development.js
perl -p -i -e 's/^(    ,host:).*$/\1 '"''/g" /usr/local/src/Windshaft-cartodb/config/environments/development.js
perl -p -i -e 's/^(    ,mapnik_version:).*$/\1 '"'2.1.1'/g" /usr/local/src/Windshaft-cartodb/config/environments/development.js


cd /usr/local/src/cartodb
echo "127.0.0.1 ${USER}.localhost.lan" | sudo tee -a /etc/hosts
export SUBDOMAIN=$USER
echo "=========================== rake:db:create ======================================="
bundle exec rake rake:db:create
echo "=========================== rake:db:migrate ======================================="
bundle exec rake rake:db:migrate
echo "=========================== cartodb:db:create_publicuser ========================="
bundle exec rake cartodb:db:create_publicuser
echo "=========================== cartodb:db:create_user ================================"
bundle exec rake cartodb:db:create_user SUBDOMAIN="${USER}" PASSWORD="${PASSWORD}" EMAIL="${EMAIL}"
echo "=========================== cartodb:db:create_importer_schema ===================="
bundle exec rake cartodb:db:create_importer_schema
echo "=========================== cartodb:db:load functions ============================="
bundle exec rake cartodb:db:load_functions

export SUBDOMAIN=$USER
set -e # Abort on error
echo "=========================== cartodb:db:set user stuff =============================="
bundle exec rake cartodb:db:set_user_quota["${SUBDOMAIN}",10240]
bundle exec rake cartodb:db:set_unlimited_table_quota["${SUBDOMAIN}"]
bundle exec rake cartodb:db:set_user_private_tables_enabled["${SUBDOMAIN}",'true']
bundle exec rake cartodb:db:set_user_account_type["${SUBDOMAIN}",'[DEDICATED]']

# Otherwise a stack overflow error.
mkdir -p /usr/local/src/cartodb/logs

chown -R vagrant:vagrant /usr/local/src