# frozen_string_literal: true

# Contêm as chamadas para os endpoints
class ParkingController < ApplicationController
  def show
    parkeds = Parking.where(plate: params[:plate])

    build_response(Parking.history(parkeds), 200)
  end

  def create
    parkeds = Parking.where(plate: params[:plate])
    return build_response('already parked', 422) if parkeds.pluck(:out).any? false

    park = Parking.new(parking_params)
    return build_response('is invalid', 422) unless park.valid?

    park.save!
    build_response(park.fetch_reservation_data, 200)
  end

  def update
    @last_parking = Parking.where(plate: params['id'])&.last

    return build_response('not found', 404) if @last_parking.nil?

    return pay if options[:act] == 'pay'

    out if options[:act] == 'out'
  end

  private

  def parking_params
    { plate: params[:plate] }
  end

  def pay
    @last_parking.update_attributes(paid: true).to_json
    build_response({}, 204)
  end

  def out
    return build_response('not paid', 422) unless @last_parking.paid

    @last_parking.update_attributes(left: true)
    build_response({}, 204)
  end
end
