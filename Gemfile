source 'https://rubygems.org'
ruby '2.2.3'

################################################################################
gem 'rails', '4.2.4'
gem 'mysql2', '~> 0.3.0'

gem 'sidekiq', '= 3.4.2'
gem 'sidekiq-status'
gem 'sinatra'

################################################################################
gem 'newrelic_rpm'
gem 'rails-bigint-pk'
gem 'configatron'
gem 'settingslogic'
gem 'rambulance'
gem 'quiet_assets'
gem 'asset_sync'

################################################################################
gem 'aws-sdk'
gem 'twitter'

################################################################################
gem 'rails-observers'
gem 'aasm'
gem 'hashie'

################################################################################
gem 'omniauth'
gem 'omniauth-twitter'
gem 'draper'

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

gem 'faml'
gem 'browser'

################################################################################
group :production, :staging do
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
group :test do
  gem 'webmock'
  gem 'vcr'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'fuubar'
  gem 'coveralls', require: false
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec-its', require: 'rspec/its'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'poltergeist'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'forgery'
  gem 'timecop'

  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rb-fsevent'
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'

  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-coolline'
end

################################################################################
group :development do
  gem 'dotenv-rails'
  gem 'web-console', '~> 2.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'awesome_print'

  gem 'annotate', require: false
  gem 'rubocop', require: false
  gem 'foreman', require: false
  gem 'powder', require: false
  gem 'travis'
  gem 'travis-lint'
end
