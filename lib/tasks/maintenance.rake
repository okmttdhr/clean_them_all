namespace :maintenance do
  namespace :sns do
    task publish: :environment do
      Job.processing.each do |job|
        Aws::SNS::Client.new.publish({
          topic_arn: configatron.aws.sns.topic_arn,
          message:   job.to_event_message(:create)
        })
      end
      puts 'OK'
    end
  end
end
