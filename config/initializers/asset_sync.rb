if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider          = 'AWS'
    Fog.credentials              = { path_style: true }
    config.aws_access_key_id     = ENV['AWS_ACCESS_KEY_ID']
    config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    config.fog_directory         = configatron.aws.s3.bucket_name
    config.fog_region            = configatron.aws.region
    config.existing_remote_files = 'delete'
    config.gzip_compression      = true
    config.manifest              = true

    config.add_local_file_paths do
      Dir.chdir(Rails.root.join('public')) do
        Dir[File.join(Webpacker::Configuration.fetch(:public_output_path), '/**/**')]
        # Dir[File.join(Webpacker.config.public_output_path, '/**/**')]
      end
    end
  end
end
