require 'liquid'

##
# Liquid plugin to strip certain HTML tags
# in the outpout of the articles excerpts.
#
module StripHtmlTags
  def strip_links(input)
    input.gsub(/<a([^>]+)>(.+?)<\/a>/mi) do
      $2.to_s
    end
  end

  def strip_imgs(input)
    empty = ''.freeze
    input.gsub(/<img\s?.*?\/?>/mi, empty)
  end
end

Liquid::Template.register_filter(StripHtmlTags)
