module Backend
  class Engine < ::Rails::Engine
    isolate_namespace Backend
    config.generators.api_only = true

    require 'csv'
    require 'twitter'
    require 'oauth'

    if Rails.env.production?
      config.eager_load_paths += Dir[
        root.join('lib'),
      ]
    end

    config.autoload_paths += Dir[
      root.join('parameters'),
      root.join('services'),
      root.join('lib'),
    ]
  end
end
