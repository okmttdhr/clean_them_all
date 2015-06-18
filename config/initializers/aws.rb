unless Rails.env.test?
  Aws.config[:credentials] = Aws::Credentials.new(ENV['AWS_ACCESS_KEY'], ENV['AWS_SECRET_KEY'])
  Aws.config[:region]      = 'ap-northeast-1'
end
