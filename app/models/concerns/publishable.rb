module Publishable
  extend ActiveSupport::Concern

  included do
    after_create do
      Aws::SNS::Client.new.publish({
        topic_arn: configatron.aws.sns.topic_arn,
        message:   self.to_event_message(:create)
      })
    end

    after_update do
      if aasm.current_event == :abort!
        Aws::SNS::Client.new.publish({
          topic_arn: configatron.aws.sns.topic_arn,
          message:   self.to_event_message(:abort)
        })
      end
      true
    end
  end

  def to_event_message(event)
    case event
    when :create
      event_message_for_create
    when :abort
      event_message_for_abort
    end
  end

  private

  def event_message_for_create
    {
      id: id,
      event: :created,
      options: {
        credentials: {
          consumer_key:        configatron.twitter.consumer_key,
          consumer_secret:     configatron.twitter.consumer_secret,
          access_token:        user.token,
          access_token_secret: user.secret,
        },
        parameters: {
          signedin_at:      parameter.signedin_at,
          statuses_count:   parameter.statuses_count,
          registered_at:    parameter.registered_at,
          collect_method:   parameter.collect_method,
          archive_url:      parameter.archive_url,
          protect_reply:    parameter.protect_reply,
          protect_favorite: parameter.protect_favorite,
          collect_from:     parameter.collect_from,
          collect_to:       parameter.collect_to,
          start_message:    parameter.start_message,
          finish_message:   parameter.finish_message,
        },
      }
    }.to_json
  end

  def event_message_for_abort
    {
      id: id,
      event: :aborted,
      options: {}
    }.to_json
  end
end
