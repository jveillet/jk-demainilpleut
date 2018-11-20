# frozen_string_literal: true

require 'dotenv/load'

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
      # Override the site URL, mainly for development purposes
      site.config['url'] = ENV['SITE_URL'] if override_site_url?
    end

    def override_site_url?
      return false unless ENV['OVERRIDE_SITE_URL']
      ENV['OVERRIDE_SITE_URL'].to_s == 'true'
    end
  end
end
