# jk-demainilpleut
Static HTML version of demainilpleut.fr using the static website generator
[Jekyll](https://jekyllrb.com/).

## Installation

This project uses [Node.js](https://nodejs.org/en/), [Gulp](http://gulpjs.com/),
[PostCSS](http://postcss.org/) as dependencies to build an minify the CSS and
JS.

On the ruby side, this project uses [Bundler](https://bundler.io/).

### For Docker
```bash
$ cd jk-demainilpleut/
# Build the docker container and install Gems dependencies and NPM dependencies
$ docker-compose build
# Run the tasks to build the CSS and JS (optional)
$ docker-compose run --rm web gulp
# Launch the Jekyll build and start the server
$ docker-compose up
# (or)
$ docker-compose run --rm web bundle exec jekyll serve -H 0.0.0.0 --incremental
# The server will run on port 8080 (see docker-compose.yml)
```

### Without Docker
```bash
$ cd jk-demainilpleut/
# Install the gem and dependecies the blog needs
$ bundle install
# Debian only: Add the latest node version to the sources
$ curl -sL https://deb.nodesource.com/setup_7.x | bash - \
# Install Node and Gulp
$ apt-get install -y nodejs
$ npm install -g gulp-cli
# Install the JS dependencies (optional)
$ npm install
# Run the tasks to build the CSS and JS (optional)
$ gulp
# Launch the Jekyll build and start the server
$ bundle exec jekyll serve --incremental
# The server will run on port 4000
```

### On [Heroku](https://www.heroku.com)

No need to store the _site directory content into the repository.
Enable the automatic deploy of a branch into your app pipeline, the static files
will be build automatically with every merge on that branch, using Rake
precompile tasks.
