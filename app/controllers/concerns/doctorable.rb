module Doctorable
  extend ActiveSupport::Concern

  def average_of_messages_visible
    Aws::CloudWatch::Client.new.get_metric_statistics({
      namespace:   'AWS/SQS',
      metric_name: 'ApproximateNumberOfMessagesVisible',
      start_time:  5.minutes.ago.iso8601,
      end_time:    Time.now.iso8601,
      period:      1.minutes,
      statistics:  ['Average'],
      dimensions:  [
        { name: 'QueueName', value: configatron.collect_and_destroy.aws.sqs.queue_name }
      ],
    }).datapoints.first.try(:average) || 0
  end
end
