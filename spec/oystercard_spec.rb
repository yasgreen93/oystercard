require 'oystercard'
require 'journey'

describe Oystercard do
  let(:journey_log) { double :journey_log }
  subject(:oystercard) { described_class.new(journey_log) }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe '#initialize' do
    it 'should start with a balance of 0' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it {expect{oystercard.top_up 5}.to change{oystercard.balance}.by 5}
    it {expect{ oystercard.top_up(95) }.to raise_error described_class::MAX_ERROR}
  end

  describe '#touch_in error' do
    it {expect{oystercard.touch_in(entry_station)}.to raise_error described_class::MIN_ERROR}
  end

  describe '#touch_out' do
    before do
      oystercard.top_up(described_class::MIN_BALANCE)
      oystercard.touch_in(entry_station)

    end


    it 'reduces balance by minimum fare when journey is complete' do
      allow(journey_log).to receive(:finish)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Journey::MIN_FARE)
    end
  end

  describe 'penalties' do
    before do
      oystercard.top_up(described_class::MIN_BALANCE)
    end
    it 'reduces balance by penalty fare when journey is incomplete (touch in twice)' do
      oystercard.top_up(described_class::MIN_BALANCE)
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_in(entry_station)}.to change{oystercard.balance}.by(-Journey::PENALTY_FARE)
    end
    it 'reduces balance by penalty fare when journey is incomplete (did not touch in)' do
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Journey::PENALTY_FARE)
    end
  end

end
