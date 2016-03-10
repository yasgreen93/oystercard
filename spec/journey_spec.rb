require 'journey'
require 'oystercard'

describe Journey do

  subject(:journey) { described_class.new }
  let(:entry_station){double(:station)}
  let(:exit_station){double(:station)}

  it {is_expected.to respond_to(:exit_station)}
  it {is_expected.to respond_to(:entry_station)}
  it {is_expected.to respond_to(:fare)}

  it "checks if a journey is not complete" do
    journey = Journey.new("Euston")
    expect(journey).to_not be_complete
  end

  it "checks if a journey is complete" do
    journey = Journey.new("Euston")
    journey.end_journey("Bank")
    expect(journey).to be_complete
  end

  describe '#end_journey' do
    it "stores the exit station" do
      expect(journey.end_journey(:exit_station)).to eq :exit_station
    end
  end
end
