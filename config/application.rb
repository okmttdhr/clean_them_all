require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module CleanThemAll
  class Application < Rails::Application
    config.exceptions_app = self.routes

    # config.active_record.observers = [
    #   'observer/user_registration',
    #   'observer/user_utilization',
    # ]

    config.active_record.table_name_prefix = 'clean_them_all_'
    config.active_record.raise_in_transactional_callbacks = true
    config.time_zone = 'Tokyo'

    I18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
    config.i18n.available_locales = [:ja, :en]
  end
end
