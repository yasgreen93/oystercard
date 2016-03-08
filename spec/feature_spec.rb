require 'oystercard'

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
    it "saves station name on touch_in" do
      oystercard.top_up(described_class::MIN_BALANCE)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end

    it "deducts MIN_BALANCE on touch out" do
      oystercard.top_up(described_class::MIN_BALANCE)
      oystercard.touch_in(entry_station)
      oystercard.top_up(described_class::MIN_BALANCE)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-described_class::MIN_BALANCE)
    end

    it "saves single journey" do
      oystercard.top_up(described_class::MIN_BALANCE)
      journey = {}
      journey[:entry_station] = "Piccadilly"
      journey[:exit_station] = "Green Park"

      oystercard.touch_in("Piccadilly")
      oystercard.touch_out("Green Park")
      expect(oystercard.journeys).to include(journey)
    end
  end
end
