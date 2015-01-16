#!/usr/bin/env bash

cd /usr/local/src/cartodb

easy_install pip
pip install -r python_requirements.txt
pip install -e git+https://github.com/RealGeeks/python-varnish.git@0971d6024fbb2614350853a5e0f8736ba3fb1f0d#egg=python-varnish
