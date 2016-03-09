require 'oystercard'
require 'journey'

describe Oystercard do
  subject(:oystercard){ described_class.new(Journey) }
  let(:dummy_station) { double :station }


  describe '#initialize' do

    it '> should be initialized with a balance of 0' do
      expect(oystercard.balance).to eq(0)
    end

    it '> should be initialized with a journey log' do
      expect(oystercard.journeys).to eq ([])
    end

    it{is_expected.to_not be_in_journey}

  end


  describe '#top_up' do

    it '> should top up the amount specified' do
      oystercard.top_up(5)
      expect(oystercard.balance).to eq(5)
    end

    it '> should have a maximum credit' do
      expect{oystercard.top_up(100)}.to raise_error "Maximum limit is #{Oystercard::MAXIMUM_TOPUP} pounds"
    end

  end


  describe '#touch_in' do

    before do
      oystercard.top_up(Oystercard::MINIMUM_FARE)
    end

    it '> should not let you touch in when balance less than minimum fare' do
      message = "Insufficient balance to touch in."
      oystercard.touch_out(dummy_station)
      expect{oystercard.touch_in(dummy_station)}.to raise_error message
    end

    it '> should change the station status to the station it touches into' do
      oystercard.touch_in(dummy_station)
      expect(oystercard.station).to eq(dummy_station)
    end

    it '> should be in journey after being touched in' do
      oystercard.touch_in(dummy_station)
      expect(oystercard).to be_in_journey
    end

    it '> should deduct penalty fare when touching in twice' do
      message = "Insufficient balance to touch in."
      oystercard.top_up(Journey::PENALTY_FARE - Oystercard::MINIMUM_FARE)
      oystercard.touch_in(dummy_station)
      expect{oystercard.touch_in(dummy_station)}.to raise_error message
    end

  end


  describe '#touch_out' do

    before do
      oystercard.top_up(Oystercard::MINIMUM_FARE)
      allow(dummy_station).to receive(:same_station?).and_return(false)
    end

    it '> should deduct the minimum fare when touched out (legally)' do
      oystercard.touch_in(dummy_station)
      expect{oystercard.touch_out(dummy_station)}.to change{oystercard.balance}.by -Oystercard::MINIMUM_FARE
    end

    it '> should set the station to nil when touched out' do
      oystercard.touch_in(dummy_station)
      oystercard.touch_out(dummy_station)
      expect(oystercard.station).to be nil
    end

    it '> should set a card to out of use when touched out' do
      oystercard.touch_in(dummy_station)
      oystercard.touch_out(dummy_station)
      expect(oystercard).not_to be_in_journey
    end

    it '> should change the journey when touched out' do
      oystercard.touch_in(dummy_station)
      oystercard.touch_out(dummy_station)
      expect(oystercard.journeys).to eq([oystercard.journey])
    end

    it '> should deduct a penalty fare when touching out twice' do
      message = "Insufficient balance to touch in."
      oystercard.top_up(Journey::PENALTY_FARE - Oystercard::MINIMUM_FARE)
      oystercard.touch_out(dummy_station)
      expect{oystercard.touch_in(dummy_station)}.to raise_error message
    end

  end


end
