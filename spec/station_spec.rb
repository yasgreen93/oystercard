require 'station'

describe Station do

  subject(:station) { described_class.new("Bank", 1) }

  describe '#initialize' do
    it {expect(station.name).to eq ("Bank")}
    it {expect(station.zone).to eq (1)}
  end

end
