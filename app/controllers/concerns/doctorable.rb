module Doctorable
  extend ActiveSupport::Concern

  def average_of_messages_visible
    Aws::CloudWatch::Client.new.get_metric_statistics({
      namespace:   'AWS/SQS',
      metric_name: 'ApproximateNumberOfMessagesVisible',
      start_time:  5.minutes.ago.iso8601,
      end_time:    Time.now.iso8601,
      period:      1.minute,
      statistics:  ['Average'],
      dimensions:  [
        { name: 'QueueName', value: configatron.collect_and_destroy.aws.sqs.queue_name }
      ],
    }).datapoints.first.try(:average) || 0
  end

  def official_account
    twitter_client.user
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = configatron.twitter.consumer_key
      config.consumer_secret     = configatron.twitter.consumer_secret
      config.access_token        = configatron.twitter.access_token
      config.access_token_secret = configatron.twitter.access_token_secret
    end
  end
end
