require 'coveralls'
Coveralls.wear!('rails')

ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'draper/test/rspec_integration'

################################################################################
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter,
]
SimpleCov.start 'rails'

################################################################################
Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false, timeout: 60)
end

################################################################################
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/models/concerns/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/controllers/concerns/**/*.rb')].each { |f| require f }

################################################################################
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_spec_type_from_file_location!
  config.infer_base_class_for_anonymous_controllers = false

  config.include FactoryGirl::Syntax::Methods
end
