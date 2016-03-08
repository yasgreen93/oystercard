require 'oystercard'

describe Oystercard do

  subject(:oystercard) {described_class.new}

  describe '#initialize'do

    it {expect(oystercard.balance).to eq 0}
    it {expect(oystercard).to_not be_in_journey}
  end

  describe '#top_up' do
    it {expect{oystercard.top_up 5}.to change{oystercard.balance}.by 5}

    it {expect{ oystercard.top_up(95) }.to raise_error described_class::MAX_ERROR}
  end

  describe '#deduct' do
    it {expect{oystercard.deduct 5}.to change{oystercard.balance}.by -5}
  end

  describe '#touch_in' do
    it {expect{oystercard.touch_in}.to change{oystercard.in_journey?}.from(false).to(true)}
  end

  describe '#touch_out' do
    it "changes in_journey from true to false" do
      oystercard.touch_in
      expect{oystercard.touch_out}.to change{oystercard.in_journey?}.from(true).to(false)
    end
  end

end
