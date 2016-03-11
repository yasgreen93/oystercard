require 'oystercard'
require 'journey'

describe Oystercard do
  let(:journey_log) { double :journey_log, current_journey: journey, no_touch_out: nil}
  let(:journey) {double :journey, fare: Journey::MIN_FARE}
  subject(:oystercard) { described_class.new(journey_log) }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  before do
    allow(journey_log).to receive(:reset).and_return nil
    allow(journey_log).to receive(:start)
  end


  describe '#initialize' do
    it 'should start with a balance of 0' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should change the balance' do
      expect { oystercard.top_up(5) }.to change{oystercard.balance}.by 5
    end

    it 'should raise an error when topping up more than the maximum' do
      expect { oystercard.top_up(95) }.to raise_error described_class::MAX_ERROR
    end
  end

  describe '#touch_in error' do
    it 'raises an error when touching in with insufficient funds' do
      expect { oystercard.touch_in(entry_station) }.to raise_error described_class::MIN_ERROR
    end
  end

  describe '#touch_out' do
    before do
      oystercard.top_up(described_class::MIN_BALANCE)
      oystercard.touch_in(entry_station)
    end

    it 'reduces balance by minimum fare when journey is complete' do
      allow(journey_log).to receive(:finish)
      expect { oystercard.touch_out(exit_station) }.to change {oystercard.balance}.by(-Journey::MIN_FARE)
    end
  end

end
