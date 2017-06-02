module Backend::Concerns::Services::Collectable::Timeline
  include Backend::Concerns::Services::Requestable

  def collect_from_timeline
    retrieve_timeline do |status|
      yield normalize_timeline_status(status)
    end
  end

  private

  def retrieve_timeline
    counter  = 0
    while counter <= 3200
      options ||= {
        count:       200,
        include_rts: true,
        trim_user:   true,
      }
      user_timeline = twitter_client.user_timeline(options)
      break if user_timeline.empty?
      options.merge!({ max_id: user_timeline.last.id - 1 })
      counter += 200

      user_timeline.each { |status| yield(status) }
    end
  end

  def normalize_timeline_status(status)
    {
      id:                  status.id.to_s,
      created_at:          status.created_at.to_s,
      in_reply_to_user_id: status.in_reply_to_user_id.to_s.presence,
      favorite_count:      status.favorite_count,
    }
  end
end
