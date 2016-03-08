require 'oystercard'

describe Oystercard do

  subject(:oystercard) {described_class.new}
  context "Feature test" do
    it {expect(oystercard.balance).to eq 0}
    it "should eq 5" do
      oystercard.top_up(5)
      expect(oystercard.balance).to eq 5
    end
    it "should raise error" do
      expect{oystercard.top_up(95)}.to raise_error described_class::MAX_ERROR
    end
  end
end
