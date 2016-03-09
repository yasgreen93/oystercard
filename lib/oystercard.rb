class Oystercard

MAXIMUM_TOPUP = 90
MINIMUM_FARE = 1
PENALTY_FARE = 6

  def initialize(journey_log_class, journey_class=Journey)
    @station = nil
    @balance = 0
    @journey_class = journey_class
    @journey_log = journey_log_class.new(journey_class)
  end

  def top_up(cash)
    raise "Maximum limit is #{MAXIMUM_TOPUP} pounds" if reached_max?(cash)
    @balance += cash
  end

  def touch_in(station_name)
    @journey_log.start(station_name)
    deduct(PENALTY_FARE) if same_station?(station_name)
    change_station(station_name)
    raise "Insufficient balance to touch in." if not_enough?

  end

  def touch_out(station_name)
    @journey_log.finish(station_name)
    @station == nil ? deduct(PENALTY_FARE) : deduct(MINIMUM_FARE)
    change_station nil
  end

  attr_reader :balance, :station, :journeys, :journey

  def in_journey?
    !@station.nil?
  end

private

  def change_station(station_name)
    @station = station_name
  end

  def same_station?(station_name)
    @station == station_name
  end

  def reached_max?(cash)
    @balance + cash > MAXIMUM_TOPUP
  end

  def not_enough?
    @balance < MINIMUM_FARE
  end

  def deduct(cash)
    @balance -= cash
  end

end
