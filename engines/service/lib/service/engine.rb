module Service
  class Engine < ::Rails::Engine
    isolate_namespace Service
    config.generators.api_only = true

    require 'builder'
  end
end
