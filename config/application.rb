require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module CleanThemAll
  class Application < Rails::Application
    config.load_defaults 5.1
    config.i18n.available_locales         = %i(ja en)
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale            = :ja
    config.time_zone                      = 'Tokyo'
    config.active_job.queue_adapter       = :sidekiq

    config.autoload_paths += Dir[]

    config.generators do |g|
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.template_engine false
      g.test_framework :rspec, view_specs: false, helper_specs: false, fixture: true
    end
  end
end
