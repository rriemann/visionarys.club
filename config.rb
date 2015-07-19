set :css_dir,               'css'
set :js_dir,                'js'
set :images_dir,            'img'
set :fonts_dir,             'fonts'

# Slim template engine
require 'slim'

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/*.htaccess', layout: false

ignore '*.kate-swp'
ignore '*.directory'
ignore 'favicon_base.png'

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Localization settings
###

activate :i18n, mount_at_root: false

ready do
  I18n.available_locales = [:en, :fr, :de]
  I18n.available_locales.each do |locale|
    proxy "/#{locale.to_s}/.htaccess", "lang.htaccess", locals: {locale: locale}, ignore: true
  end
end

###
# Helpers
###

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do
   def mdt(identifier, options = nil)
     Kramdown::Document.new(I18n.t identifier, options).to_html
   end
  def hello()
    "hello"
  end
end

# Build-specific configuration
configure :build do
  # activate :minify_html
  
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
  
    # Make favicons
  # use: https://github.com/follmann/middleman-favicon-maker
  activate :favicon_maker, :icons => {
    "favicon_base.png" =>   [
      { icon: "apple-touch-icon-114x114-precomposed.png" },
      { icon: "apple-touch-icon-72x72-precomposed.png" },
      { icon: "apple-touch-icon-57x57-precomposed.png" },
      { icon: "apple-touch-icon-precomposed.png", size: "57x57" },
      { icon: "apple-touch-icon.png", size: "57x57" },
      { icon: "favicon.png", size: "16x16" },
      { icon: "favicon.ico", size: "16x16" },
    ]
  }
end

# activate :deploy do |deploy|
#   deploy.method = :rsync
#   deploy.host   = "rriemann.rigel.uberspace.de"
#   deploy.path   = "/var/www/virtual/rriemann/visionarys.club"
#   # deploy.build_before = true # default: false
#   # deploy.method   = :ftp
#   deploy.clean = true # remove orphaned files on remote host, default: false
# end

after_build do |builder|
  require 'fileutils'
  
  build_dir = config[:build_dir]
  
  # work-around to remove copies of font-awesome files. Where are they pulled in?
  Dir.glob(build_dir + '/fonts/*wesome*').each { |f| File.delete(f) if File.file? f }
  
  # work-around to move translated files from /:lang/file to /file.:lang
  I18n.available_locales.each do |locale|
    Dir.glob("#{build_dir}/#{locale.to_s}/*.html").each do |file|
      FileUtils.move file, File.join("#{build_dir}/#{File.basename file}.#{locale}")
    end
    # FileUtils.ln_s "#{locale}/index.html", "#{build_dir}/index.html.#{locale}"
  end
end