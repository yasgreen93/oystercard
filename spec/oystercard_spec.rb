require 'oystercard'

describe Oystercard do

  describe 'initialize' do
    it '> should be initialized with a balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe 'top_up' do
    it '> should top up the amount specified' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it '> should have a maximum limit of £90' do
      expect{subject.top_up(100)}.to raise_error "Maximum limit is 90 pounds"
    end

  end

  describe 'deduct' do

    it '> should deduct from the balance the amount specified' do
      subject.top_up(5)
      expect(subject.deduct(4)).to eq(1)
    end

  end

  describe 'touch_in' do

    it '> should set card to in use when touched in' do
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end

  end

  describe 'touch_out' do

    it '> should set a card to out of use when touched out' do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end

  end

end
