# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require 'rubygems'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "rspec/rails"
require "factory_girl_rails"
require 'database_cleaner'
require 'authengine/testing_support/factories/user_factory'
require 'authengine/testing_support/factories/organization_factory'
require 'debugger'


ENGINE_RAILS_ROOT = File.join( File.dirname(__FILE__), '../')
ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "test.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

# Load support files
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }
Dir[File.join(Rails.root, "spec/factories/*.rb")].each{|f| require f }
Dir[File.join(ENGINE_RAILS_ROOT, "spec/factories/*.rb")].each{|f| require f }
RSpec.configure do |config|
  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include RSpec::Matchers

  # == Mock Framework
  #config.mock_with :rspec
  config.mock_with :flexmock

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    ActionMailer::Base.deliveries = []
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
