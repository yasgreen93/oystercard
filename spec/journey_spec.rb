require 'journey'

describe Journey do
  start_station = :start_station
  end_station = :end_station
  nil_station = nil
  subject(:journey) {described_class.new start_station}

  describe '#initialize' do

    it '> should be initialized with a starting station' do
      expect(journey.start_station).to eq(start_station)
    end

    it '> should be initialized with an nil ending station' do
      expect(journey.end_station).to eq(nil)
    end

  end

  describe '#compute_fare' do

    it 'return a fare when a full journey is completed' do
      journey.add_exit_station(start_station)
      expect(journey.compute_fare).to eq(Journey::MINIMUM_FARE)
    end

    it 'return a penalty fare when a journey has no beginning' do
      journey = described_class.new nil_station
      expect(journey.compute_fare).to eq(Journey::PENALTY_FARE)
    end

    it 'returns a penalty fare when a journey has no end' do
      journey = described_class.new start_station
      journey.add_exit_station(nil)
      expect(journey.compute_fare).to eq(Journey::PENALTY_FARE)
    end

  end

end
