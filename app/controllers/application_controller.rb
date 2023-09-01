# frozen_string_literal: true

set :default_content_type, :json

# Centraliza as regras padrão de todos os controllers
class ApplicationController
  attr_accessor :params, :options

  SUCCESS = [200, 204].freeze

  def initialize(args, **options)
    @params = args
    @options = options
  end

  def build_response(message, status)
    return { data: message.to_json, status: } if SUCCESS.include? status

    { data: { errors: { plate: [message] } }.to_json, status: }
  end
end
