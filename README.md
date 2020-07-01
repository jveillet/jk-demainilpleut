# jk-demainilpleut

[![Build Status](https://github.com/jveillet/jk-demainilpleut/workflows/CI/badge.svg)](https://github.com/jveillet/jk-demainilpleut/actions)
[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo=jveillet/jk-demainilpleut)](https://dependabot.com)

Static HTML version of demainilpleut.fr using the static website generator
[Jekyll](https://jekyllrb.com/).

## Installation

This project uses [Node.js](https://nodejs.org/en/), [Gulp](http://gulpjs.com/),
[PostCSS](http://postcss.org/) as dependencies to build an minify the CSS and
JS.

On the ruby side, this project uses [Bundler](https://bundler.io/).

### With Docker

```bash
$ git clone git@github.com:jveillet/jk-demainilpleut.git
$ cd jk-demainilpleut/
# Build the docker container and install Gems dependencies and NPM dependencies
$ docker-compose build
# Run the tasks to build the CSS and JS
$ docker-compose run --rm web gulp build
# Lint the CSS and JS (required before commiting any CSS and/or JS updates).
$ docker-compose run --rm web gulp lint
# Launch the Jekyll build and start the server
$ docker-compose up
# (or)
$ docker-compose run --rm web bundle exec jekyll serve -H 0.0.0.0 --incremental
# The server will run on port 8080 (see docker-compose.yml)
```

### On linux (Debian 8+)

```bash
# Add the latest node version to the sources
$ curl -sL https://deb.nodesource.com/setup_10.x | bash - \
# Install Node and Gulp
$ apt-get install -y nodejs
$ npm install -g gulp-cli
# Install the JS dependencies
$ npm install
# Run the tasks to build the CSS and JS
$ gulp build
# Lint the CSS and JS (required before commiting any CSS and/or JS updates).
$ gulp lint
```

### On macOS (Sierra+)

```bash
$ brew install node
# Install Gulp
$ npm install -g gulp-cli
# Install the JS dependencies
$ npm install
# Run the tasks to build the CSS and JS
$ gulp build
# Lint the CSS and JS (required before commiting any CSS and/or JS updates).
$ gulp lint
```

### Build and launch the Jekyll project (every OS)

```bash
$ git clone git@github.com:jveillet/jk-demainilpleut.git
$ cd jk-demainilpleut/
# Install the gem and dependecies the blog needs
$ bundle install
# Launch the Jekyll build and start the server
$ bundle exec jekyll serve --incremental
# The server will run on port 4000
```

### Individual Tasks

```bash
# Building CSS (assets will be compiled and installed in assets/css/)
$ gulp build:css
# Building Javascript (assets will be compiled and installed in assets/js/)
$ gulp build:js
# Global build (CSS + JS, compiled and installed into their relative folders in assets/)
$ gulp build
# Linting CSS (lint every individual component from the _assets/css/ folder)
$ gulp lint:css
# Linting JS (lint every individual scripts from the _assets/js/ folder)
$ gulp lint:js
# Global codebase linting (CSS + JS)
$ gulp lint
# Delete bundled CSS and JS files
$ gulp clean
```

## Tests

Basic tests are performed on the structure of the site (broken links, alt attributes on images,..), by using the
[html-proofer](https://github.com/gjtorikian/html-proofer) Ruby Gem.

They are launched automatically with every Pull Requests, via [GitHub Actions](https://help.github.com/en/github/automating-your-workflow-with-github-actions) (see [cibuild.yml](https://github.com/jveillet/jk-demainilpleut/blob/master/.github/workflows/cibuild.yml) file).

You can run them manually via command line:

```bash
./bin/cibuild.sh
```

Or with Docker:

```bash
docker-compose run --rm web bin/cibuild.sh
```

## Contributing

### To the code

This project only accepts Pull Requests that references an issue.

1. Fork it ( http://github.com/jveillet/jk-demainilpleut/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Run the specs and our linter (bin/cibuild)
4. Commit your changes (git commit -am 'Add some feature')
5. Push to the branch (git push origin my-new-feature)
6. Create new Pull Request

### To the articles

1. Fork it ( http://github.com/jveillet/jk-demainilpleut/fork )
2. Create your feature branch for the new page (git checkout -b page/my-post-title)
3. Create a post with the help of the command line: `bundle exec jekyll post "My post title"`, or a draft: `bundle exec jekyll draft "My post title"`
4. When you are ready, publish the post or draft: `bundle exec jekyll publish _drafts/my-post-title.md`. You can specify a date by using the `--date` argument.
5. Push to the branch (git push origin page/my-post-title)
6. Create new Pull Request
