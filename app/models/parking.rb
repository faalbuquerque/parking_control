# frozen_string_literal: true

require 'securerandom'

# Contêm a logica do estacionamento
class Parking  < ModelBase
  before_create :generate_code

  field :plate,       type: String
  field :paid,        type: Boolean, default: false
  field :out,         type: Boolean, default: false
  field :reservation, type: String

  validates :plate, format: { with: /\A[a-zA-Z]{3}-[0-9]{4}\Z/ }

  def generate_code
    self.reservation = SecureRandom.alphanumeric
  end

  def self.history(parks)
    return [] if parks.empty?

    parks.map(&:fetch_parking_data)
  end

  def fetch_parking_data
    parking_data
  end

  def fetch_reservation_data
    reservation_data
  end

  private

  def fetch_time
    diff = (DateTime.now - created_at.to_datetime)

    days, hours, minutes, seconds = fetch_periods(diff)

    return "#{seconds} seconds" if minutes.zero?
    return "#{minutes} minutes" if hours.zero?
    return "#{hours} hours" if days.zero?

    "#{days} days"
  end

  def fetch_periods(time_diff)
    [time_diff.to_i, (time_diff * 24).to_i, (time_diff * 24 * 60).to_i,(time_diff * 24 * 60 * 60).to_i]
  end

  def parking_data
    {
      time: fetch_time,
      paid:,
      out:,
      plate:,
      reservation:
    }
  end

  def reservation_data
    {
      reservation:,
      plate:,
      entered_at: created_at
    }
  end
end
