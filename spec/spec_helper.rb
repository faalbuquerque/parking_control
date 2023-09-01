# frozen_string_literal: true

require 'simplecov'

SimpleCov.start

ENV['SINATRA_ENV'] = 'test'
ENV['MONGOID_ENV'] = 'test'

require 'rack/test'
require 'rspec'
require 'active_support/testing/time_helpers'

Dir.glob('./config/initializers/*.rb').each { |file| require file }
Dir.glob('./app/models/*.rb').each { |file| require file }
Dir.glob('./app/controllers/*.rb').each { |file| require file }
Dir.glob('./spec/support/*.rb').each { |file| require file }

require './config/routes'

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include ActiveSupport::Testing::TimeHelpers
  config.include JsonHelper

  config.after(:each) do
    Mongoid.load!(File.join(File.dirname(__FILE__), 'support', 'mongoid.yml'))
    Mongoid.purge!
  end
end
