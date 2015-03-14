module FileUpload
  extend ActiveSupport::Concern

  def upload
    file       = params[:qqfile]
    unique_key = Digest::MD5.file(file.tempfile).hexdigest()

    obj = configatron.aws.s3.bucket.objects["uploaded/#{unique_key}/tweets.zip"]

    unless obj.exists?
      obj.write(
        file.tempfile, :reduced_redundancy => true, :single_request => true,
        :content_type => file.content_type, :cache_control => "private, max-age=#{60*60*24}",
        :acl => :public_read
      )
    end

    tempfile = file.tempfile.path
    if File::exists?(tempfile)
      File::delete(tempfile)
    end

    url = obj.public_url(:secure => false).to_s

    respond_to do |format|
      format.json { render :json => { :success => true, :url => url }, :status => 200 }
      format.any  { render :json => { :success => true, :url => url }, :status => 200 }
    end

  rescue => ex
    Airbrake.notify(ex)

    respond_to do |format|
      format.json { render :json => { :success => false }, :status => 500 }
      format.any  { render :json => { :success => false }, :status => 500 }
    end

  end
end
