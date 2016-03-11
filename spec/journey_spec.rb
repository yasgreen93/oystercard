require 'journey'
require 'oystercard'

describe Journey do

  let(:entry_station) { double(:station) }
  subject(:journey) { described_class.new(entry_station) }
  let(:exit_station) { double(:station) }

  it 'checks if a journey is not complete' do
    expect(journey).to_not be_complete
  end

  it 'checks if a journey is complete' do
    journey.end_journey(exit_station)
    expect(journey).to be_complete
  end

  describe '#end_journey' do
    it 'stores the exit station' do
      expect(journey.end_journey(exit_station)).to eq exit_station
    end
  end

  describe '#fare' do
    it 'should return the penalty fare when journey is incomplete' do
      expect(journey.fare).to eq described_class::PENALTY_FARE
    end

    it 'should return the minimum fare when travelling in the same zone' do
      allow(entry_station).to receive(:zone).and_return 1
      allow(exit_station).to receive(:zone).and_return 1
      journey.end_journey(exit_station)
      expect(journey.fare).to eq described_class::MIN_FARE
    end

    it 'should calculate the fare when travelling from zone 1 to zone 3' do
      allow(entry_station).to receive(:zone).and_return 1
      allow(exit_station).to receive(:zone).and_return 3
      journey.end_journey(exit_station)
      expect(journey.fare).to eq described_class::MIN_FARE + 2
    end

    it 'should calculate the fare when travelling from zone 4 to zone 2' do
      allow(entry_station).to receive(:zone).and_return 4
      allow(exit_station).to receive(:zone).and_return 2
      journey.end_journey(exit_station)
      expect(journey.fare).to eq described_class::MIN_FARE + 2
    end
  end
end
