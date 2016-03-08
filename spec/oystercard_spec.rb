require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }
  let(:dummy_station) { double :station }
  let(:dummy_station2) { double :station }

  describe '#initialize' do

    it '> should be initialized with a balance of 0' do
      expect(oystercard.balance).to eq(0)
    end

    it '> should be initialized with a nil station' do
      expect(oystercard.station).to eq(nil)
    end

    it '> should be initialized with journeys' do
      expect(oystercard.journeys).to eq ({})
    end

  end

  describe 'journey status' do
    it{is_expected.to_not be_in_journey}
  end

  describe '#top_up' do

    it '> should top up the amount specified' do
      oystercard.top_up(5)
      expect(oystercard.balance).to eq(5)
    end

    it '> should have a maximum limit' do
      expect{oystercard.top_up(100)}.to raise_error "Maximum limit is #{Oystercard::MAXIMUM_TOPUP} pounds"
    end

  end

  describe '#touch_in' do

    before{oystercard.top_up(Oystercard::MINIMUM_FARE)}

    it '> should set card to in use when touched in' do
      oystercard.touch_in(dummy_station)
      expect(oystercard.in_journey?).to eq(true)
    end

    it '> should not let you touch in when balance less than minimum fare' do
      oystercard.touch_out(dummy_station2)
      expect{oystercard.touch_in(dummy_station)}.to raise_error "Insufficient balance to touch in."
    end

    it '> should change the station status to the station it touches into' do
      oystercard.touch_in(dummy_station)
      expect(oystercard.station).to eq(dummy_station)
    end

  end

  describe '#touch_out' do

    before{oystercard.top_up(Oystercard::MINIMUM_FARE)}

    it '> should set a card to out of use when touched out' do
      oystercard.touch_in(dummy_station)
      oystercard.touch_out(dummy_station2)
      expect(oystercard.in_journey?).to eq(false)
    end

    it '> should deduct the minimum fare when touched out' do
      # oystercard.touch_out(dummy_station2)
      # expect{oystercard.touch_in(dummy_station)}.to raise_error "Insufficient balance to touch in."
      expect{oystercard.touch_out(dummy_station2)}.to change{oystercard.balance}.by -Oystercard::MINIMUM_FARE
    end

    xit '> should deduct the minimum fare when touched out' do
      oystercard.touch_out(dummy_station2)
      expect{oystercard.touch_in(dummy_station)}.to raise_error "Insufficient balance to touch in."
    end

    it '> should set the station to nil when touched out' do
      oystercard.touch_in(dummy_station)
      oystercard.touch_out(dummy_station2)
      expect(oystercard.station).to be nil
    end

    it '> should store the stations in the journey history' do
      oystercard.touch_in(dummy_station)
      oystercard.touch_out(dummy_station2)
      expect(oystercard.journeys).to eq({dummy_station => dummy_station2})
    end

  end

end
