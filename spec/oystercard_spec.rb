require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  max_limit = Oystercard::MAX_LIMIT
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

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
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end

    it 'raise error when touched in with insufficient balance' do
    	message = "You have an insufficicent balance"
    	expect{card.touch_in(entry_station)}.to raise_error message
    end

    it 'should save entry station to card' do
    	card.top_up(5)
      card.touch_in(entry_station)
      expect(card.entry_station).to eq entry_station
    end
  end

  describe '#touch_out' do
    it 'should change the status of the card to not be in_journey' do
      card.top_up(5)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card).not_to be_in_journey
    end

    it 'should reduce the balance by minimum fare' do
      card.top_up(5)
      card.touch_in(entry_station)
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by(-1)
    end

    it 'should forget entry station when touched out' do
    	card.top_up(5)
      card.touch_in(entry_station)
     expect{ card.touch_out(exit_station) }.to change{ card.entry_station}.to nil
    end
  end

  describe 'journeys' do
    it 'should have an empty list of journeys by default' do
      expect(card.journeys).to be_empty
    end

    it 'should create one journey after touching in and out' do
      card.top_up(5)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journeys).to eq [{entry_station => exit_station}]
    end
  end
end
