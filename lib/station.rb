require_relative 'oystercard'

class Station
attr_reader :name, :zone

  def initialize(station_name, zone)
    @name = station_name
    @zone = zone
  end

end
