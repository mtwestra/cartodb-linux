#!/usr/bin/env bash

cd /usr/local/src/CartoDB-SQL-API
git checkout master
npm install
mkdir logs

cd /usr/local/src/Windshaft-cartodb
git checkout master
npm install
mkdir logs

