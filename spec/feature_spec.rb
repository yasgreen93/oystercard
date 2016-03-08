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
  end
end
