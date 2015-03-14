if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider          = 'AWS'
    Fog.credentials              = { path_style: true }
    config.aws_access_key_id     = ENV['AWS_ACCESS_KEY']
    config.aws_secret_access_key = ENV['AWS_SECRET_KEY']
    config.fog_directory         = 'assets.kurorekishi.me'
    config.fog_region            = ENV['AWS_REGION']
    config.existing_remote_files = 'delete'
    config.gzip_compression      = true
    config.manifest              = true
  end
end
