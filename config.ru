require 'rack/jekyll'
require 'yaml'

use Rack::Deflater

run Rack::Jekyll.new
