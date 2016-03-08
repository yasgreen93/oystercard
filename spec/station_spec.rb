require 'station'

describe Station do
  dummy_name = :banana_station_name
  dummy_zone = :zone_number
  subject(:station){described_class.new dummy_name , dummy_zone}


  describe '#initialize' do

    it '> should initialize with a name' do
      expect(station.name).to eq dummy_name
    end

    it '> should initalize with a zone' do
      expect(station.zone).to eq dummy_zone
    end

  end

end
