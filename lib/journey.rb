
class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  attr_reader :start_station, :end_station

  def initialize(start_station=nil)
    @start_station = start_station
    @end_station = nil
  end

  def compute_fare
    return PENALTY_FARE if incomplete_journey?
    MINIMUM_FARE
  end

  def add_exit_station(end_station)
    @end_station = end_station
  end

private

  def incomplete_journey?
    @start_station.nil? || @end_station.nil?
  end

end
