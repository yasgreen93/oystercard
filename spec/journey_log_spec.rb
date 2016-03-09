require 'journey_log'

describe JourneyLog do
  subject(:journeylog) {described_class.new(journey_class)}
  let(:station) {double :station}
  let(:journey_class) {double :journey_class, new: journey}
  let(:journey) {double :journey}

  before{allow(journey).to receive(:add_exit_station).and_return true}

  describe '#start' do
    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      allow(journey).to receive(:exiting?).and_return false
      journeylog.start(station)
      expect(journeylog.list_journeys).to include journey
    end
  end

  describe '#finish' do
    it 'should add an exit station to the current_journey' do
      allow(journey_class).to receive(:new).and_return journey
      allow(journey).to receive(:exiting?).and_return false
      journeylog.start(station)
      allow(journey).to receive(:exiting?).and_return true
      journeylog.finish(station)
      expect(journeylog.list_journeys).to include journey
    end
  end


end
