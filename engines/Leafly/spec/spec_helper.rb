# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require 'nokogiri'
require 'open-uri'
require 'capybara/rails'
require 'capybara/rspec'
require 'mechanize'
require 'webmock'
require 'factory_girl_rails'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }
VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  # c.default_cassette_options = { :record => :none }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end
RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]
FactoryGirl.find_definitions
