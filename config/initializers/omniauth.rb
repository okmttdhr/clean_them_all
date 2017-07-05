Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, configatron.twitter.consumer_key, configatron.twitter.consumer_secret, {
    path_prefix: '/cleaner/auth'
  }
  OmniAuth.config.on_failure = SessionsController.action(:failure)
  OmniAuth.config.logger     = Rails.logger
end
