#!/usr/bin/env bash

# halt script on error
set -e

# Buil the static site first
bundle exec jekyll build --config _config.yml

# Test the HTML of the site
time ./bin/htmltest -c ./bin/.htmltest.yml
