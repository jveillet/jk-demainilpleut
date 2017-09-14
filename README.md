# jk-demainilpleut
Static HTML version of demainilpleut.fr using the static website generator [Jekyll](https://jekyllrb.com/).

## Installation

This project uses [Node.js](https://nodejs.org/en/), [Gulp](http://gulpjs.com/), [PostCSS](http://postcss.org/) as dependencies to build an minify the CSS and JS.

On the ruby side, this project uses [Bundler](https://bundler.io/).

### For Docker
```bash
# Build the project image
$ docker-compose build
# install RubyGems dependencies
$ docker-compose run --rm blog bundle install
# Install the NPM dependencies into the container
$ docker run -it --rm -v $PWD:/app/ jkdemainilpleut_blog npm install
# Compile and minify JS + CSS
$ docker-compose run --rm blog gulp
# Launch jekyll build & server
$ docker-compose up
# (or)
$ docker-compose run --rm blog bundle exec jekyll serve -H 0.0.0.0
# The server will run on the 8080 port (see docker-compose.yml)
```

### Without Docker
```bash
# Install the gem and dependecies the blog needs
$ bundle install
# Install the tools to work on the CSS and JS
$ apt-get install -y nodejs
$ npm install -g gulp
# Install the JS dependencies
$ npm install
# Run the tasks to build the CSS and JS
$ gulp
# Launch the Jekyll build and start the server
$ bundle exec jekyll serve
```

### On [Heroku](https://www.heroku.com)

No need to store the _site directory content into the repository.
Enable the automatic deploy of a branch into your app pipeline, the static files will be build automatically with every merge on that branch, using Rake precompile tasks.
