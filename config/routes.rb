# frozen_string_literal: true

require 'sinatra/namespace'

before '/*' do
  params = request.body.read
  @params = JSON.parse(params).deep_symbolize_keys unless params.empty?
end

namespace '/parking' do
  post '' do
    reply ParkingController.new(params).create
  end

  put '/:id/out' do
    reply ParkingController.new(params, act: 'out').update
  end

  put '/:id/pay' do
    reply ParkingController.new(params, act: 'pay').update
  end

  get '/:plate' do
    reply ParkingController.new(params).show
  end
end

def reply(action)
  status action[:status]
  action[:data]
end
