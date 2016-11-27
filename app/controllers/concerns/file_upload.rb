module FileUpload
  extend ActiveSupport::Concern

  def upload
    file = params[:qqfile]
    key  = "twitter_archive/#{current_user.id}/#{Time.zone.now.to_s(:number)}/tweets.zip"

    store_file(key, file.tempfile)
    url = get_presigned_url(key)

    respond_to do |format|
      format.json { render json: { success: true, url: url }, status: 200 }
    end
  end

  private

  def get_presigned_url(key)
    Aws::S3::Resource.new.bucket(configatron.aws.s3.bucket_name).object(key).presigned_url(:get, expires_in: 1.day)
  end

  def store_file(key, data)
    Aws::S3::Client.new.put_object(bucket: configatron.aws.s3.bucket_name, key: key, body: data, acl: 'public-read')
  end
end
