# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Park do
  describe '#generate_code' do
    it { expect(described_class.new.generate_code).not_to be_empty }
  end

  describe 'validates' do
    context 'when to generate plate number valid' do
      it { expect(described_class.new(plate: 'aaa-1234')).to be_valid }
    end

    context 'when to generate plate number invalid' do
      it { expect(described_class.new(plate: 'aaa-bbb')).not_to be_valid }
    end
  end

  describe '#fetch_parking_data' do
    let(:parking) { described_class.create!(plate: 'aaa-1234') }

    it 'successfully' do
      parking_data = parking.fetch_parking_data

      expectation = { time: parking.send(:fetch_time),
                      paid: park.paid,
                      left: parking.left,
                      plate: parking.plate,
                      reservation: parking.reservation
                    }

      expect(parking_data).to be_eql(expectation)
    end
  end
end
