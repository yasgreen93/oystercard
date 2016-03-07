require 'oystercard'

describe Oystercard do

  describe 'initialize' do
    it '> should be initialized with a balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe 'top_up' do
    it '> should top up the amount specified' do
      expect(subject.top_up(5)).to eq(5)
    end

    it '> should have a maximum limit of £90' do
      expect{subject.top_up(100)}.to raise_error "Maximum limit is 90 pounds"
    end

  end

end
