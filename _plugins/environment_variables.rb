# frozen_string_literal: true

require 'dotenv/load'

module Jekyll
  ##
  # Plugin to add environment variables to the `site`
  # object in Liquid templates
  #
  class EnvironmentVariablesGenerator < Generator
    def generate(site)
      # Add other environment variables to `site.config` here...
      # site.config['my_custom_config'] = ENV['MY_CUSTOM_CONFIG']
    end
  end
end
