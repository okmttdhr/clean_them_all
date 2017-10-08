# service credentials
configatron.twitter.consumer_key    = Rails.application.secrets.twitter_consumer_key
configatron.twitter.consumer_secret = Rails.application.secrets.twitter_consumer_secret

# twitter official account
configatron.twitter.access_token        = Rails.application.secrets.twitter_access_token
configatron.twitter.access_token_secret = Rails.application.secrets.twitter_access_token_secert

# AWS
configatron.aws.region         = 'ap-northeast-1'
configatron.aws.s3.bucket_name = 'kurorekishi.me'

# bugsnag
configatron.bugsnag.api_key = Rails.application.secrets.bugsnag_api_key
