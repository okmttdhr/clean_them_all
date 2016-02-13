module ApplicationHelper
  def notice_messages
    index = Time.now.to_i % Message.count
    [Message.start_message[index], Message.finish_message[index]]
  end

  def text_decorated_with_entity(tweet)
    text = tweet.retweeted_status? ? tweet.retweeted_status.text.dup : tweet.text.dup
    return text unless tweet.entities?
    decorate_hashtag!(text, tweet.hashtags)
    decorate_mention!(text, tweet.user_mentions)
    decorate_url!(text, tweet.urls)
    decorate_media!(text, tweet.media)
    text
  end

  private

  def decorate_hashtag!(text, hashtags)
    hashtags.each do |entity|
      replace  = "##{entity.text}"
      replaced = link_to(replace, "https://twitter.com/search?q=#{URI.encode(entity.text)}")
      text.gsub!(replace, replaced)
    end
  end

  def decorate_media!(text, media)
    media.each do |entity|
      text.gsub!(entity.url.to_s, link_to(entity.display_url, entity.url.to_s))
    end
    # TODO: メディアデータを埋め込む
  end

  def decorate_url!(text, urls)
    urls.each do |entity|
      text.gsub!(entity.url.to_s, link_to(entity.display_url, entity.url.to_s))
    end
  end

  def decorate_mention!(text, mentions)
    mentions.each do |entity|
      replace  = "@#{entity.screen_name}"
      replaced = link_to(replace, "https://twitter.com/#{entity.screen_name}")
      text.gsub!(replace, replaced)
    end
  end
end
