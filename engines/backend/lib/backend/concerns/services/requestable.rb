module Backend::Concerns::Services::Requestable
  extend ActiveSupport::Concern

  def oauth_client
    consumer = OAuth::Consumer.new(
      credentials.consumer_key,
      credentials.consumer_secret,
      site:'https://api.twitter.com/'
    )
    OAuth::AccessToken.new(consumer, credentials.access_token, credentials.access_token_secret)
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = credentials.consumer_key
      config.consumer_secret     = credentials.consumer_secret
      config.access_token        = credentials.access_token
      config.access_token_secret = credentials.access_token_secret
    end
  end
end
