redis_config = YAML.load_file(Rails.root.join('config', 'redis.yml'))
redis        = "#{redis_config[Rails.env]}/0"
namespace    = 'collect_and_destroy:sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { url: redis, namespace: namespace }
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis, namespace: namespace }
  config.average_scheduled_poll_interval = 1
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 12.hours
  end
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

Sidekiq.default_worker_options = { backtrace: true }
