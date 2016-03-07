require 'oystercard'

describe Oystercard do

  describe '#balance'do
    it { expect(subject).to respond_to(:balance) }
    it "expect balance to be 0" do
      expect(subject.balance).to eq 0
    end
  end
end
