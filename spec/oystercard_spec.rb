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

  describe '#in_journey?' do
    it 'should not be in journey on initialization' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'should change the status of the card to in_journey' do
      card.top_up(5)
      card.touch_in
      expect(card).to be_in_journey
    end

    it 'raise error when touched in with insufficient balance' do
    	message = "You have an insufficicent balance"
    	expect{card.touch_in}.to raise_error message
    end
  end

  describe '#touch_out' do
    it 'should change the status of the card to not be in_journey' do
      card.top_up(5)
      card.touch_in
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it 'should reduce the balance by minimum fare' do
      card.top_up(5)
      card.touch_in
      expect{ card.touch_out }.to change{ card.balance }.by(-1)
    end
  end
end
