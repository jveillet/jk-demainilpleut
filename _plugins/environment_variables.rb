require 'dotenv'

Dotenv.load

module Jekyll
  ##
  # Plugin to add environment variables to the `site`
  # object in Liquid templates
  #
  class EnvironmentVariablesGenerator < Generator
    def generate(site)
      site.config['google_analytics'] = ENV['GA_TRACKING_ID']
      # Add other environment variables to `site.config` here...
      site.config['cdn'] = ENV['S3_IMG_BUCKET_URL']
    end
  end
end