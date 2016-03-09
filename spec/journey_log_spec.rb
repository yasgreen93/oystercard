require 'journey_log'

describe JourneyLog do
  subject(:journeylog) {described_class.new(journey_class)}
  let(:station) {double :station}
  let(:journey_class) {double :journey_class, new: journey}
  let(:journey) {double :journey}

  describe '#start' do
    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      journeylog.start(station)
      expect(journeylog.journeys).to include journey
    end
  end

  describe '#finish' do
    it 'should add an exit station to the current_journey' do
      allow(journey_class).to receive(:new).and_return journey
      journeylog.start(station)
      journeylog.finish(station)
      expect(list_journeys).to include journey
    end
  end


end
