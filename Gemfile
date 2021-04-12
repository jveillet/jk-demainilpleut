# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.6'

gem 'dotenv', '~> 2.7.6'
gem 'jekyll', '~> 4.2'
gem 'oj'
gem 'puma', '~> 5.1.1'
gem 'rack-jekyll', git: 'https://github.com/adaoraul/rack-jekyll',
                   ref: 'master'
gem 'rake', '~> 13.0.3'
gem 'secure_headers', '~> 6.3'

group :jekyll_plugins do
  gem 'jekyll-archives', '~> 2.2.1'
  gem 'jekyll-compose', '~> 0.12.0'
  gem 'jekyll-feed', '~> 0.15.1'
  gem 'jekyll-paginate', '~> 1.1.0'
  gem 'jekyll-sitemap', '~> 1.4.0'
end

group :development, :test do
  gem 'html-proofer', '~> 3.19'
  gem 'pkg-config', '~> 1.4'
  gem 'rspec', '~> 3.10'
end
