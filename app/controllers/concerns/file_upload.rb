module FileUpload
  extend ActiveSupport::Concern

  def upload
    file       = params[:qqfile]
    unique_key = Digest::MD5.file(file.tempfile).hexdigest

    write_s3_object("uploaded/#{unique_key}/tweets.zip", file.tempfile)
    url = get_s3_object.public_url

    respond_to do |format|
      format.json { render json: { success: true, url: url }, status: 200 }
    end
  end

  private

  def get_s3_object(key)
    s3_client.get_object(bucket: configatron.aws.s3.bucket_name, key: key, body: data)
  end

  def write_s3_object(key, data)
    s3_client.put_object(bucket: configatron.aws.s3.bucket_name, key: key, body: data, acl: :public_read)
  end

  def s3_client
    Aws::S3::Client.new
  end
end
