require 'oystercard'
require 'journey'

describe Oystercard do

  subject(:oystercard) {described_class.new}
  let(:entry_station){double(:station)}
  let(:exit_station){double(:station)}

  it {is_expected.to respond_to(:touch_in).with(1).argument}
  it {is_expected.to respond_to(:touch_out).with(1).argument}
  it {is_expected.to respond_to(:journeys)}

  describe '#initialize'do

    it {expect(oystercard.balance).to eq 0}
    it {expect(oystercard.journeys).to be_empty}
  end

  describe '#top_up' do
    it {expect{oystercard.top_up 5}.to change{oystercard.balance}.by 5}
    it {expect{ oystercard.top_up(95) }.to raise_error described_class::MAX_ERROR}
  end

  describe '#touch_in error' do
    it {expect{oystercard.touch_in(entry_station)}.to raise_error described_class::MIN_ERROR}
  end

  # describe '#touch_in' do
  #
  # end

  describe '#touch_out' do
    before do
      oystercard.top_up(described_class::MIN_BALANCE)
      oystercard.touch_in(entry_station)
    end
    it "stores a record of journeys taken" do
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys[0]).to be_a(Journey)
    end
    it 'reduces balance by minimum fare when journey is complete' do
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Journey::MIN_FARE)
    end
  end

  describe '#balance' do
    # it 'reduces balance by penalty fare when journey is incomplete' do
    #   oystercard.top_up(described_class::MIN_BALANCE)
    #   expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Journey::PENALTY_FARE)
    # end
    it 'reduces balance by penalty fare when journey is incomplete (touch in twice)' do
      2.times{oystercard.top_up(described_class::MIN_BALANCE)}
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_in(entry_station)}.to change{oystercard.balance}.by(-Journey::PENALTY_FARE)
    end

    it 'reduces balance by penalty fare when journey is incomplete (did not touch in)' do
      oystercard.top_up(described_class::MIN_BALANCE)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Journey::PENALTY_FARE)
    end
  end

end
