require 'oystercard'

class Journey

attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil) #KEEP NIL
    @entry_station = entry_station
  end

  def complete?
    !(exit_station == nil || entry_station == nil)
  end

  def end_journey(station)
    @exit_station = station
  end

end
