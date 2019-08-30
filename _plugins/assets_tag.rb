# frozen_string_literal: true

require 'liquid'
require 'oj'

##
# Assets source tag
#
# Allow to call a tag `assets_src` in a template with the name of the asset.
# This is used in conjoction with Gulp's gulp-rev plugin to generate unique
# version hashes with the assets names.
# It permits to swapp an asset name with the generated one.
#
# Example:
# {% assets_src site.min.css %}
# This will look in the manifest-rev.json for the key site.min.css and return
# the value associated, like site-1234.min.css
#
class AssetsSourceTag < Liquid::Tag
  MANIFEST_PATH = ENV['REV_MANIFEST_PATH'] || 'assets/rev-manifest.json'

  def initialize(tag_name, text, tokens)
    super
    @text = text
    @tokens = tokens
  end

  def manifest?
    File.file?(MANIFEST_PATH)
  end

  def manifest
    @manifest ||= load_manifest_file
  end

  def load_manifest_file
    return {} unless manifest?

    file = File.read MANIFEST_PATH
    return {} unless file

    Oj.load(file)
  end

  def render(_context)
    # Get the parameter sent with the tag
    asset_name = @text.strip
    return '' unless manifest.key?(asset_name)

    # Lookup the asset name in the manifest-rev.json
    manifest[asset_name].to_s
  end
end

Liquid::Template.register_tag('assets_src', AssetsSourceTag)
