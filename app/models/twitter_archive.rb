class TwitterArchive
  attr_reader :file, :object_key

  def initialize(file)
    @file       = file
    @object_key = generate_object_key
  end

  def store_file
    s3.bucket(configatron.aws.s3.bucket_name).put_object(key: object_key, body: file.tempfile, expires: 1.day.since, acl: 'public-read')
  end

  def create_presigned_url
    s3.bucket(configatron.aws.s3.bucket_name).object(object_key).presigned_url(:get, expires_in: 1.day.to_i)
  end

  private

  def generate_object_key
    "#{Rails.env}/v1/twitter_archive/#{SecureRandom.uuid}/tweets.zip"
  end

  def s3
    Aws::S3::Resource.new
  end
end
