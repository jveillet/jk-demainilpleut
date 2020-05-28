# frozen_string_literal: true

require 'rack/jekyll'
require 'yaml'
require 'secure_headers'

# HSTS max-age: One year minimum
HSTS_MAX_AGE = 31536000

SecureHeaders::Configuration.default do |config|
   # Add "; preload" and submit the site to hstspreload.org for best protection.
  config.hsts = "max-age=#{HSTS_MAX_AGE}; includeSubDomains; preload"
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.referrer_policy = %w(origin-when-cross-origin strict-origin-when-cross-origin)
  config.csp = {
    # # "meta" values. these will shape the header, but the values are not included in the header.
    preserve_schemes: true, # default: false. Schemes are removed from host sources to save bytes and discourage mixed content.
    disable_nonce_backwards_compatibility: false, # default: false. If false, `unsafe-inline` will be added automatically when using nonces. If true, it won't. See #403 for why you'd want this.
    # # directive values: these values will directly translate into source directives
    default_src: %W('self'),
    base_uri: %w('self'),
    block_all_mixed_content: true, # see http://www.w3.org/TR/mixed-content/
    child_src: %w('self'), # if child-src isn't supported, the value for frame-src will be set.
    font_src: %w('self' https://fonts.gstatic.com),
    form_action: %w('self'),
    frame_ancestors: %w('none'),
    img_src: %w('self' data: https://avatars1.githubusercontent.com),
    manifest_src: %w('self'),
    media_src: %w('none'),
    object_src: %w('self'),
    script_src: %w('self' 'unsafe-inline' https://cdnjs.cloudflare.com;),
    style_src: %w('self' 'unsafe-inline' https://fonts.googleapis.com),
    worker_src: %w('self'),
    upgrade_insecure_requests: true, # see https://www.w3.org/TR/upgrade-insecure-requests/
  }
end

use Rack::Deflater
use SecureHeaders::Middleware

run Rack::Jekyll.new
