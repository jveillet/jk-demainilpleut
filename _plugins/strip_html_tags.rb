require 'liquid'

module StripHtmlTags
  def strip_links(input)
    empty = ''.freeze
    input.gsub(/<a([^>]+)>(.+?)<\/a>/mi) do
      $2.to_s
    end
  end
  def strip_imgs(input)
    empty = ''.freeze
    input.gsub(/<img\s?.*?\/?>/i, empty)
  end
end

Liquid::Template.register_filter(StripHtmlTags)
