#!/usr/bin/env bash

# halt script on error
set -e

export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

# Buil the static site first
bundle exec jekyll build --config _config.yml

# Test the HTML of the site
time bundle exec rake test:proofer
