source 'https://rubygems.org'

################################################################################
gem 'rails', '4.2.1'

################################################################################
gem 'mysql2'
gem 'rails-bigint-pk'
gem 'dotenv-rails'
gem 'configatron'
gem 'settingslogic'
gem 'airbrake'
gem 'quiet_assets'
gem 'asset_sync'

################################################################################
gem 'aws-sdk-v1'
gem 'unf'

################################################################################
gem 'aasm'
gem 'rails-observers'
gem 'draper'

################################################################################
gem 'omniauth'
gem 'omniauth-twitter'

################################################################################
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jbuilder', '~> 2.0'

################################################################################
gem 'jquery-rails'
gem 'jquery-rails-cdn'

gem 'lazyload-rails'
gem 'modernizr-rails'

gem 'compass-rails', '>= 1.1.7'
gem 'bourbon'
gem 'normalize-rails'
gem 'google-webfonts-rails'

gem 'haml-rails'
gem 'browser'

################################################################################
group :production do
  gem 'newrelic_rpm'
  gem 'unicron'
  gem 'unicorn-rails'
end

################################################################################
group :development do
  gem 'capistrano', '~> 2.0'
  gem 'capistrano-ext'
  gem 'capistrano-unicorn', require: false
  gem 'capistrano-maintenance', require: 'capistrano/maintenance'
end

################################################################################
group :development, :test do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'rspec-its', require: 'rspec/its'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rb-fsevent'
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
  gem 'faker'
  gem 'forgery'
  gem 'capybara'
  gem 'poltergeist'
  gem 'timecop'
  gem 'simplecov', require: false
  gem 'fuubar'
  gem 'travis'
  gem 'travis-lint'
  gem 'coveralls', require: false
  gem 'rubocop', require: false
end

################################################################################
group :development do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-coolline'
  gem 'awesome_print'

  gem 'annotate', require: false
  gem 'foreman', require: false
  gem 'powder', require: false
end
