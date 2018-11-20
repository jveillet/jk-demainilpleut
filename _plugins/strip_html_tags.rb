# frozen_string_literal: true

require 'liquid'

##
# Liquid plugin to strip certain HTML tags
# in the outpout of the articles excerpts.
#
module StripHtmlTags
  EMPTY_STRING = ''

  def strip_links(input)
    input.gsub(%r{<a([^>]+)>(.+?)</a>}mi) do
      Regexp.last_match(2)
    end
  end

  def strip_imgs(input)
    input.gsub(%r{<img\s?.*?\/?>}mi, EMPTY_STRING)
  end
end

Liquid::Template.register_filter(StripHtmlTags)
