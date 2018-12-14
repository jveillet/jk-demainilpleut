#!/usr/bin/env bash

set -e # halt script on error

export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

bundle exec jekyll build
time bundle exec htmlproofer ./_site --disable-external --allow-hash-href
