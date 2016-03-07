require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  max_limit = Oystercard::MAX_LIMIT

  it 'should initialize with a balance of 0' do
    expect(card.balance).to be_zero
  end

  it 'should have a maximum limit' do
    expect(max_limit).to be_a Integer
  end

  describe '#top_up' do
    it 'should top up with the provided credit' do
      expect{ card.top_up 1 }.to change{ card.balance }.by 1
    end

    it 'should raise error when exceeding limit' do
      message = "Limit of #{max_limit} exceeded"
      expect{ card.top_up (max_limit + 1) }.to raise_error message
    end
  end
end
