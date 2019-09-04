#!/usr/bin/env bash

# halt script on error
set -e

export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

# Buil the static site first
bundle exec jekyll build --config _config.yml

RACK_ENV=test bundle exec rspec

# Test the HTML of the site
time RACK_ENV=test bundle exec rake test:proofer
