Airbrake.configure do |config|
  config.api_key = ENV['ERRBIT_API_KEY']
  config.host    = 'cohakim-errbit.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
  config.environment_name = Rails.env
end
