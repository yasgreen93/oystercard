require 'oystercard'

describe Oystercard do

  subject(:oystercard) {described_class.new}
  let(:station){double(:station)}

  it {is_expected.to respond_to(:touch_in).with(1).argument}
  it {is_expected.to respond_to(:entry_station)}

  describe '#initialize'do

    it {expect(oystercard.balance).to eq 0}
    it {expect(oystercard).to_not be_in_journey}
  end

  describe '#top_up' do
    it {expect{oystercard.top_up 5}.to change{oystercard.balance}.by 5}
    it {expect{ oystercard.top_up(95) }.to raise_error described_class::MAX_ERROR}
  end

  describe '#touch_in' do
    before {oystercard.top_up(described_class::MIN_BALANCE)}
    it {expect{oystercard.touch_in(station)}.to change{oystercard.in_journey?}.from(false).to(true)}
    it {expect{oystercard.touch_in(station)}.to change{oystercard.entry_station}.from(nil).to(station)}
  end

  describe '#touch_in error' do
    it {expect{oystercard.touch_in(station)}.to raise_error described_class::MIN_ERROR}
  end

  describe '#touch_out' do
    before do
      oystercard.top_up(described_class::MIN_BALANCE)
      oystercard.touch_in(station)
    end
    it {expect{oystercard.touch_out}.to change{oystercard.in_journey?}.from(true).to(false)}
    it {expect{oystercard.touch_out}.to change{oystercard.balance}.by(-described_class::MIN_BALANCE)}
    it {expect{oystercard.touch_out}.to change{oystercard.entry_station}.from(station).to(nil)}
  end

end
