# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Jekyll do
  let(:overrides) do
    {
      'source': source_dir,
      'destination': dest_dir,
      'url': 'http://example.org'
    }
  end
  let(:config) do
    Jekyll.configuration(overrides)
  end
  let(:site) { Jekyll::Site.new(config) }
  let(:contents) { File.read(dest_dir('index.html')) }
  before(:each) do
    site.process
  end

  it 'filters the anchor links' do
    expect(contents).to match(/Sample Text. Generic link/i)
    expect(contents).to_not match(/<a href=/)
  end

  it 'filters the images' do
    expect(contents).to match(/Sample Text. Generic link/i)
    expect(contents).to_not match(/<img src=/)
  end

  it 'filters the CSS classes' do
    expect(contents).to match(/<p\s?>Sample Text 2<\/p>/i)
    expect(contents).to_not match(/class=/)
  end
end
