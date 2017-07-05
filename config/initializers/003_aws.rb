Aws.config[:region] = configatron.aws.region
if Rails.env.development?
  Aws.config[:credentials] = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
end
