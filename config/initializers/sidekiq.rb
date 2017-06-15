require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq-unique-jobs'
require 'sidekiq/scheduler'
require 'sidekiq-scheduler/web'

redis_config = YAML.load_file(Rails.root.join('config', 'redis.yml'))
redis        = "#{redis_config[Rails.env]}/1"
schedule     = YAML.load_file(Rails.root.join('config', 'scheduler.yml'))

Sidekiq.configure_client do |config|
  config.redis = { url: redis }
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis }
  config.average_scheduled_poll_interval = 5
  config.on(:startup) do
    Sidekiq.schedule = schedule
    Sidekiq::Scheduler.reload_schedule!
  end
end

Sidekiq.default_worker_options = {
  retry: 0, backtrace: false,
  unique: :until_executed, unique_args: ->(args) { [ args.first.except('job_id') ] }
}
