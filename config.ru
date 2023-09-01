# frozen_string_literal: true

Dir.glob('./config/initializers/*.rb').each { |file| require file }

Dir.glob('./app/models/*.rb').each { |file| require file }
Dir.glob('./app/controllers/*.rb').each { |file| require file }

require './config/routes'

run Sinatra::Application
