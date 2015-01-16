#!/usr/bin/env bash
# Install CartoDB for a development environment.
# This script can be run from the Vagrantfile or manually. See the README.
sudo cp config/* /usr/local/etc
chmod u+x setup/*.sh

source settings
echo "---------------------------- starting deb-deps.sh -------------------------------"
sudo setup/deb-deps.sh
echo "---------------------------- starting postgres-setup.sh -------------------------------"
sudo setup/postgres-setup.sh
echo "---------------------------- starting postgis-install.sh -------------------------------"
sudo setup/postgis-install.sh
echo "---------------------------- starting postgis-setup.sh -------------------------------"
sudo setup/postgis-setup.sh
echo "---------------------------- starting pg_schema_triggers -------------------------------"
sudo setup/trigger-setup.sh
echo "---------------------------- starting fetch-sources.sh -------------------------------"
sudo setup/fetch-sources.sh
echo "---------------------------- starting cartodb postgres extension -------------------------------"
sudo setup/cartodb-extension.sh
echo "---------------------------- starting python-deps.sh -------------------------------"
sudo setup/python-deps.sh
echo "---------------------------- starting node-deps.sh -------------------------------"
sudo setup/node-deps.sh
echo "---------------------------- starting ruby-deps.sh -------------------------------"
sudo setup/ruby-deps.sh
echo "---------------------------- starting cartodb-install.sh -------------------------------"
sudo setup/cartodb-install.sh 
echo "---------------------------- starting cartodb-setup.sh -------------------------------"
sudo setup/cartodb-setup.sh 
echo "---------------------------- end of initial setup -------------------------------"

echo "---------------------------- Make sure redis is running -------------------------"
pgrep redis-server || redis-server &

echo "---------------------------- start Windshaft app -------------------------------"
cd /usr/local/src/Windshaft-cartodb
sudo nohup node app.js development &

echo "---------------------------- start SQL API --------------------------------------"
cd /usr/local/src/CartoDB-SQL-API
sudo nohup node app.js development &

cd /usr/local/src/cartodb
echo "---------------------------- start resque script -------------------------------"
bundle exec script/resque &

echo "---------------------------- start web server ----------------------------------"
bundle exec rails s -d -p 3000
