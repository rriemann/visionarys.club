# ========================================================================
# Site settings
# ========================================================================
set :site_title,            "Visionary's Club"
set :site_description,      "Website of the Visionary's Club"
set :site_url_production,   "visionarys.club"
set :site_url_development,  "0.0.0.0:4567"
set :css_dir,               'css'
set :js_dir,                'js'
set :images_dir,            'img'
set :fonts_dir,             'fonts'

# Sitemap XML
require "builder"
page "/sitemap.xml", :layout => false

# Slim template engine
require "slim"

# necessary for copyright in footer
require "date"

# Internationalization
activate :i18n

# Use relative URLs
activate :relative_assets

# Pretty URLs
activate :directory_indexes
set :trailing_slash, true

# Autoprefixer
activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
  config.cascade  = false
  config.inline   = false
end

# ========================================================================
# Page options, layouts, aliases and proxies
# ========================================================================

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html",
# :locals => {:which_fake_page => "Rendering a fake page with a local
# variable" }

# ========================================================================
# Helpers
# ========================================================================

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# ========================================================================
# Development-specific configuration
# ========================================================================
configure :development do
  set :site_url, "#{site_url_development}"
  set :sass, :sourcemap => :inline, style: :nested
  
  set :slim, {
    # :format  => :html5,
    # :attr_wrapper => '"',
    # :attr_delims => {'(' => ')', '[' => ']'}, # removed '{' => '}' from default
    :indent => '    ',
    :pretty => true,
    :sort_attrs => false
  }
end

# ========================================================================
# Build-specific configuration
# ========================================================================
configure :build do
  set :site_url, "#{site_url_production}"
  set :sass, style: :compressed
  
  # activate :minify_css
  activate :minify_html
  activate :minify_javascript
  activate :gzip
  
  # Enable cache buster
  activate :asset_hash, :exts => ['.css', '.png', '.jpg', '.gif', '.js']

  # Ignore files/dir during build process
  ignore "favicon_template.png"
  ignore "sitemap.yml"
  
  # Create favicon and device-specific icons
  activate :favicon_maker, :icons => {
    "favicon_template.png" => [
      { icon: "apple-touch-icon-152x152-precomposed.png" },
      { icon: "apple-touch-icon-144x144-precomposed.png" },
      { icon: "apple-touch-icon-120x120-precomposed.png" },
      { icon: "apple-touch-icon-114x114-precomposed.png" },
      { icon: "apple-touch-icon-76x76-precomposed.png" },
      { icon: "apple-touch-icon-72x72-precomposed.png" },
      { icon: "apple-touch-icon-60x60-precomposed.png" },
      { icon: "apple-touch-icon-57x57-precomposed.png" },
      { icon: "apple-touch-icon-precomposed.png", size: "57x57" },
      { icon: "apple-touch-icon.png", size: "57x57" },
      { icon: "favicon-196x196.png" },
      { icon: "favicon-160x160.png" },
      { icon: "favicon-96x96.png" },
      { icon: "favicon-32x32.png" },
      { icon: "favicon-16x16.png" },
      { icon: "favicon.png", size: "16x16" },
      { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
      { icon: "mstile-144x144", format: "png" },
    ]
  }
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = "rriemann.rigel.uberspace.de"
  deploy.path   = "/var/www/virtual/rriemann/visionarys.club"
  # deploy.build_before = true # default: false
  # deploy.method   = :ftp
  deploy.clean = true # remove orphaned files on remote host, default: false
end
