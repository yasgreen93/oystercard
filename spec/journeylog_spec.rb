require 'journeylog'

describe JourneyLog do
  let(:journey_class) {double :journey_class, new: journey}
  let(:journey) {double :journey}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  subject(:journeylog) {described_class.new(journey_class)}

  describe '#start' do
    it 'should start a journey' do
      expect(journey_class).to receive(:new)
      subject.start(entry_station)
    end
  end

  describe '#finish' do
    it 'should end a journey' do
      expect(journey).to receive(:end_journey)
      subject.start(entry_station)
      subject.finish(exit_station)
    end
  end

end
