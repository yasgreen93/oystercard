require 'journey'

describe Journey do
  start_station = :start_station
  end_station = :end_station
  nil_station = nil
  subject(:journey) {described_class.new start_station, end_station}

  describe '#initialize' do

    it '> should be initialized with a starting station' do
      expect(journey.start_station).to eq(start_station)
    end

    it '> should be initialized with an ending station' do
      expect(journey.end_station).to eq(end_station)
    end

  end

  describe '#compute_fare' do

    it 'return a fare when a full journey is completed' do
      expect(journey.compute_fare).to eq(1)
    end

    it 'return a penalty fare when a journey has no beginning' do
      journey = described_class.new nil_station , end_station
      expect(journey.compute_fare).to eq(6)
    end

    it 'returns a penalty fare when a journey has no end' do
      journey = described_class.new start_station , nil_station
      expect(journey.compute_fare).to eq(6)
    end

  end

end
