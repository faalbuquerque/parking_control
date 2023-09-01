# frozen_string_literal: true

Dir.glob('./config/initializers/*.rb').each { |file| require file }

run Sinatra::Application