class Journey

attr_reader :entry_station, :exit_station

MIN_FARE = 1
PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  def complete?
    !(exit_station == nil || entry_station == nil)
  end

  def end_journey(station)
    @exit_station = station
  end

  def fare
    complete? ? MIN_FARE : PENALTY_FARE
  end

end
