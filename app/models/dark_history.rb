class DarkHistory
  PER_PAGE = 20

  def self.open(id, page = 1)
    bucket_name  = 'cohakim.collect-and-destroy-development'

    dark_history = Aws::S3::Client.new.get_object(bucket: bucket_name, key: "#{id}/dark_history").body

    offset = (page - 1) * PER_PAGE
    dark_history.each_line.lazy.select { |line|
      dark_history.lineno >= offset
    }.first(PER_PAGE).map {|line|
      Twitter::Tweet.new(ActiveSupport::JSON.decode(line).with_indifferent_access)
    }
  end
end
