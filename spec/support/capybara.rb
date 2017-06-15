require 'capybara'
require 'capybara/rspec'

Capybara.javascript_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chrome_options: {
        'args' => %w(headless disable-gpu window-size=1680,1050),
      },
    )
  )
end
