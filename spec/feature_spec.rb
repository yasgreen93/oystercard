require 'oystercard'
require 'journey'

describe Oystercard do

  subject(:oystercard) {described_class.new}
  let(:entry_station){double(:station)}
  let(:exit_station){double(:station)}

  context "Feature test" do
    it {expect(oystercard.balance).to eq 0}
    it "should eq 5 after top-up" do
      oystercard.top_up(5)
      expect(oystercard.balance).to eq 5
    end

    let(:station){double(:station)}

    it "deducts MIN_BALANCE on touch out" do
      oystercard.top_up(described_class::MIN_BALANCE)
      oystercard.touch_in(entry_station)
      oystercard.top_up(described_class::MIN_BALANCE)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-described_class::MIN_BALANCE)
    end
    let(:station_p){double(:station)}
    let(:station_gp){double(:station)}
    let(:journey){double(:journey, entry_station: station_p, exit_station: station_gp)}

    it "saves single journey" do
      oystercard.top_up(described_class::MIN_BALANCE)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys[0]).to be_a(Journey)
    end
  end
end
