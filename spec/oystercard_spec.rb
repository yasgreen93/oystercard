require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }

  it 'should initialize with a balance of 0' do
    expect(card.balance).to be_zero
  end

  describe '#top_up' do
    it 'should top up with the provided credit' do
      expect{ card.top_up 1 }.to change{ card.balance }.by 1
    end
  end
end
