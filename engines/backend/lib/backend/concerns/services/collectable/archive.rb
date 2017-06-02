module Backend::Concerns::Services::Collectable::Archive
  def collect_from_archive
    retrieve_archive do |status|
      yield normalize_archive_status(status)
    end
  end

  private

  def retrieve_archive
    Tempfile.open(['tmp', '.zip'], binmode: true) do |fp|
      fp << download_archive(@collect_parameter.archive_url)
      Tempfile.open(['tmp', '.csv']) do |cp|
        cp << extract_tweet_csv(fp.path)
        CSV.foreach(cp.path, headers: true, header_converters: :symbol) do |status|
          next if (status[:tweet_id].blank? || status[:timestamp].blank?)
          yield status
        end
      end
    end
  end

  def normalize_archive_status(status)
    {
      id:                    status[:tweet_id],
      created_at:            status[:timestamp],
      in_reply_to_user_id:   status[:in_reply_to_user_id].presence,
      favorite_count:        0,
    }
  end

  private

  READ_ARCHIVE_COMMAND = 'curl -s "%{source}"'
  UNCOMPRESS_COMMAND   = "unzip -l %{source} 2>/dev/null | grep -m 1 tweets.csv | awk '{print $4}' | xargs unzip -p %{source}"

  def download_archive(url)
    %x( #{READ_ARCHIVE_COMMAND % { source: url }} )
  end

  def extract_tweet_csv(path)
    %x( #{UNCOMPRESS_COMMAND % { source: path }} )
  end
end
