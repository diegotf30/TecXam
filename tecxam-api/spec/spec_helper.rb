ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "capybara/rails"
require "capybara/rspec"
require "prickle/capybara"
require "pundit/rspec"
require "rspec/rails"
require "devise"
require 'devise/jwt/test_helpers'
require "sinatra"
require "json_matchers/rspec"

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

Capybara.javascript_driver = :webkit
Capybara.default_max_wait_time = 3

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
end

JsonMatchers.schema_root = "spec/support/schemas"

RSpec.configure do |config|
  include Prickle::Capybara
  config.include RequestHelpers

  config.infer_spec_type_from_file_location!
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  Warden.test_mode!

  config.after :each do
    Warden.test_reset!
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:each) do
    ActionMailer::Base.deliveries.clear
  end

  config.include Capybara::DSL
  config.include FactoryBot::Syntax::Methods
  config.include Prickle::Capybara
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :feature
end
