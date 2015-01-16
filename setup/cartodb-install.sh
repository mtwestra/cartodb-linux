#!/usr/bin/env bash
source settings
echo "=========================== installing cartodb ========================="
cd /usr/local/src/cartodb
bundle install

mv config/app_config.yml.sample config/app_config.yml
mv config/database.yml.sample config/database.yml