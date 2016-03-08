require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }

  describe 'initialize' do

    it '> should be initialized with a balance of 0' do
      expect(oystercard.balance).to eq(0)
    end

  end

  describe 'journey status' do
    it{is_expected.to_not be_in_journey}
  end

  describe 'top_up' do
    it '> should top up the amount specified' do
      oystercard.top_up(5)
      expect(oystercard.balance).to eq(5)
    end

    it '> should have a maximum limit' do
      expect{oystercard.top_up(100)}.to raise_error "Maximum limit is #{Oystercard::MAXIMUM_TOPUP} pounds"
    end

  end

  describe 'deduct' do

    it '> should deduct from the balance the amount specified' do
      oystercard.top_up(5)
      expect(oystercard.deduct(4)).to eq(1)
    end

  end

  describe 'touch_in' do

    before{oystercard.top_up(Oystercard::MINIMUM_FARE)}

    it '> should set card to in use when touched in' do
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq(true)
    end

    it '> should not let you touch in when balance less than minimum fare' do
      oystercard.deduct(Oystercard::MINIMUM_FARE)
      expect{oystercard.touch_in}.to raise_error "Insufficient balance to touch in."
    end

  end

  describe 'touch_out' do

    before{oystercard.top_up(Oystercard::MINIMUM_FARE)}

    it '> should set a card to out of use when touched out' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq(false)
    end

  end

end
