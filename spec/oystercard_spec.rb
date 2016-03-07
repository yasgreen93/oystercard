require 'oystercard'

describe Oystercard do

  describe '#balance'do
    it { expect(subject).to respond_to(:balance) }
    it { expect(subject).to respond_to(:top_up).with(1).argument }

    it "expect balance to be 0" do
      expect(subject.balance).to eq 0
    end

    it 'can top up balance' do
      expect{subject.top_up 5}.to change{subject.balance}.by 5
    end
  end
end
