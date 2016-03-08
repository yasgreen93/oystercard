require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }
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

    before{oystercard.top_up(Oystercard::MINIMUM_FARE)}

    it '> should not let you touch in when balance less than minimum fare' do
      oystercard.touch_out(dummy_station)
      expect{oystercard.touch_in(dummy_station)}.to raise_error "Insufficient balance to touch in."
    end

    it '> should change the station status to the station it touches into' do
      oystercard.touch_in(dummy_station)
      expect(oystercard.station).to eq(dummy_station)
    end

    it '> should be in journey after being touched in' do
      oystercard.touch_in(dummy_station)
      expect(oystercard).to be_in_journey
    end

  end


  describe '#touch_out' do

    before{oystercard.top_up(Oystercard::MINIMUM_FARE)}

    it '> should deduct the minimum fare when touched out' do
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

  end


end
