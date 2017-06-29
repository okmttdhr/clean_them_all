source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# base
gem 'rails', '~> 5.1.2'
gem 'mysql2'
gem 'puma', '~> 3.7'

# system
gem 'bugsnag'
gem 'configatron'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# backend
gem 'sidekiq'
gem 'sidekiq-unique-jobs'
gem 'sidekiq-scheduler'

# engines
gem 'api',     path: 'engines/api'
gem 'backend', path: 'engines/backend'
gem 'service', path: 'engines/service'

# support
gem 'aws-sdk'

# model
gem 'activerecord-import'
gem 'aasm'
gem 'active_hash'

# controller
gem 'omniauth'
gem 'omniauth-twitter'

# decorator
gem 'active_decorator'

# view
gem 'haml-rails'
gem 'jbuilder', '~> 2.5'
gem 'browser'
gem 'rails-timeago'

# js
gem 'webpacker', github: 'rails/webpacker'
gem 'webpacker-react', '~> 0.3.1'
gem 'js-routes'

# css preprocessor
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'

# jquery packages
gem 'jquery-rails'
gem 'modernizr-rails'
gem 'pickadate-rails'
gem 'remodal-rails'

# css packages
gem 'normalize-rails'
gem 'bourbon'
gem 'google-webfonts-rails', github: 'masarakki/google-webfonts-rails', branch: 'for-rails5'

group :production do
  gem 'newrelic_rpm'
end

group :test do
  gem 'webmock'
  gem 'database_cleaner'
  gem 'nyan-cat-formatter'
  gem 'coveralls', require: false
end

group :development, :test do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'

  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'forgery'
  gem 'timecop'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'rubocop', require: false
  gem 'travis'
  gem 'travis-lint'

  gem 'bullet'
  gem 'beautiful-log'
  gem 'awesome_print', require: false
  gem 'foreman'
  gem 'annotate'
  gem 'i18n_generators'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-yarn'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'
  gem 'capistrano-sidekiq'
end
