# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.2'

# Loads environment variables from `.env`.
gem 'dotenv', '~> 2.7.6'

# Jekyll is a simple, blog aware, static site generator.
gem 'jekyll', '~> 4.2'

# The fastest JSON parser and object serializer.
gem 'oj', '~> 3.12'

# Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications.
gem 'puma', '~> 5.4.0'

# Rack-Jekyll transforms your Jekyll app into a Rack application.
gem 'rack-jekyll', git: 'https://github.com/adaoraul/rack-jekyll',
                   ref: 'master'

# Rake is a Make-like program implemented in Ruby.
gem 'rake', '~> 13.0.3'

# Manages application of security headers with many safe defaults.
gem 'secure_headers', '~> 6.3'

group :jekyll_plugins do
  # Automatically generate post archives by dates, tags, and categories.
  gem 'jekyll-archives', '~> 2.2.1'
  # Streamline your writing in Jekyll with these commands.
  gem 'jekyll-compose', '~> 0.12.0'
  # A Jekyll plugin to generate an Atom feed of your Jekyll posts.
  gem 'jekyll-feed', '~> 0.15.1'
  # Built-in Pagination Generator for Jekyll.
  gem 'jekyll-paginate', '~> 1.1.0'
  # Automatically generate a sitemap.xml for your Jekyll site.
  gem 'jekyll-sitemap', '~> 1.4.0'
end

group :development, :test do
  # Test your rendered HTML files to make sure they're accurate.
  gem 'html-proofer', '~> 3.19'
  # pkg-config can be used in your extconf.rb to properly detect need libraries for compiling Ruby native extensions.
  gem 'pkg-config', '~> 1.4'
  # BDD for Ruby
  gem 'rspec', '~> 3.10'
end

# WEBrick is an HTTP server toolkit that can be configured as an HTTPS server, a proxy server, and a virtual-host server.
gem "webrick", "~> 1.7"
