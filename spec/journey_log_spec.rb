require 'journey_log'

describe JourneyLog do
  subject(:journeylog) {described_class.new(journey_class)}
  let(:station) {double :station}
  let(:journey_class) {double :journey_class, new: journey}
  let(:journey) {double :journey}

  before do
    allow(journey).to receive(:add_exit_station).and_return true
    allow(journey_class).to receive(:new).and_return journey
  end

  describe '#start' do
    it 'records a journey' do
      allow(journey).to receive(:exiting?).and_return false
      journeylog.start(station)
      expect(journeylog.list_journeys).to include journey
    end

    it 'should not replace an incomplete journey if start twice' do
      allow(journey).to receive(:exiting?).and_return false
      journeylog.start(station)
      journeylog.start(station)
      expect(journeylog.list_journeys.length).to eq 2
    end
  end

  describe '#finish' do
    it 'should add an exit station to the current_journey' do
      allow(journey).to receive(:exiting?).and_return false
      journeylog.start(station)
      allow(journey).to receive(:exiting?).and_return true
      journeylog.finish(station)
      expect(journeylog.list_journeys).to include journey
    end

    it 'should store an incomplete finish' do
      allow(journey).to receive(:exiting?).and_return true
      journeylog.finish(station)
      expect(journeylog.list_journeys).to include journey
    end
  end


end
