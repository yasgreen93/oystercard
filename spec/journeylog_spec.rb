require 'journeylog'

describe JourneyLog do
  subject(:journeylog) {described_class.new(journey_class)}
  let(:journey_class) {double :journey_class, new: Journey}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) {double :journey}

  it {is_expected.to respond_to(:start).with(1).argument}
  it {is_expected.to respond_to(:finish).with(1).argument}

  describe '#start' do
    # it 'should record a journey' do
    #   journeylog.start(entry_station)
    #   expect(journeylog.list_journeys).to include journey
    # end
  end

  describe '#finish' do

  end

end
