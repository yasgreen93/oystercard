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
    complete? ? calculate : PENALTY_FARE
  end

  private

  def calculate
    return MIN_FARE if entry_station.zone == exit_station.zone
    (entry_station.zone - exit_station.zone).abs + MIN_FARE
  end

end
