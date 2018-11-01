# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module School
  class Application < Rails::Application
    config.load_defaults 5.1
    config.i18n.load_path        += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = %i[en ua]
    config.i18n.default_locale    = :ua
  end
end
