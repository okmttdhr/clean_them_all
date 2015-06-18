module Publishable
  extend ActiveSupport::Concern

  def to_params
    {
      id: id,
      credentials: {
        :consumer_key        => configatron.twitter.consumer_key,
        :consumer_secret     => configatron.twitter.consumer_secret,
        :access_token        => user.token,
        :access_token_secret => user.secret,
      },
      parameters: {
        :signedin_at      => parameter.signedin_at,
        :statuses_count   => parameter.statuses_count,
        :registered_at    => parameter.registered_at,
        :collect_method   => parameter.collect_method,
        :archive_url      => parameter.archive_url,
        :protect_reply    => parameter.protect_reply,
        :protect_favorite => parameter.protect_favorite,
        :collect_from     => parameter.collect_from,
        :collect_to       => parameter.collect_to,
        :start_message    => parameter.start_message,
        :finish_message   => parameter.finish_message,
      }
    }.to_json
  end
end
