require File.expand_path('../boot', __FILE__)

require 'rails/all'

# PDFKit
require 'pdfkit'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module N2
  class Application < Rails::Application
    
    #ActiveAdmin fix
    config.override_gem_home = false
    
    # Deflater for speed!
    config.middleware.use Rack::Deflater
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    # Add fonts path
    #config.assets.paths << "#{Rails.root}/app/assets/fonts"

    # Precompile additional assets
    #config.assets.precompile += %w( .svg .eot .woff .ttf ) 
    
    # PDFKit
    config.middleware.use PDFKit::Middleware
    
    
  end
end
