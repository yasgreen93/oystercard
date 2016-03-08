require 'journey'

describe Journey do
  start_station = :start_station
  end_station = :end_station
  subject(:journey) {described_class.new start_station, end_station}

  describe '#initialize' do

    it '> should be initialized with a starting station' do
      expect(journey.start_station).to eq(start_station)
    end

    it '> should be initialized with an ending station' do
      expect(journey.end_station).to eq(end_station)
    end

  end

end
