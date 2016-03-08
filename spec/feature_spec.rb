require 'oystercard'

describe Oystercard do

  subject(:oystercard) {described_class.new}
  context "Feature test" do
    it {expect(oystercard.balance).to eq 0}
    it "should eq 5 after top-up" do
      oystercard.top_up(5)
      expect(oystercard.balance).to eq 5
    end

    it "should eq -5 after deduct" do
      oystercard.deduct(5)
      expect(oystercard.balance).to eq -5
    end

    it "should raise error when exceeding max balance" do
      expect{oystercard.top_up(95)}.to raise_error described_class::MAX_ERROR
    end

    it "raises an error if insufficient balance at touch_in" do
        expect{oystercard.touch_in}.to raise_error described_class::MIN_ERROR
    end

    it "can touch in when balance sufficient" do
      oystercard.top_up(described_class::MIN_BALANCE)
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it "can touch out" do
      oystercard.touch_out
      expect(oystercard).to_not be_in_journey
    end


  end
end
