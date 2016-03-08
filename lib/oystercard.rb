class Oystercard

MAXIMUM_TOPUP = 90
MINIMUM_FARE = 1

  def initialize
    @station = nil
    @balance = 0
    @journeys = []
  end

  def top_up(cash)
    raise "Maximum limit is #{MAXIMUM_TOPUP} pounds" if reached_max?(cash)
    @balance += cash
  end

  def touch_in(station_name)
    #journey.add_frist_station(fwjju)
    raise "Insufficient balance to touch in." if not_enough?
    change_station(station_name)
  end

  def touch_out(station_name)
    log_journey(station_name)
    deduct MINIMUM_FARE
    change_station nil
  end

  attr_reader :balance, :station, :journeys

  def in_journey?
    !@station.nil?
  end

private

  def log_journey(station_name)
     current_journey = Journey.new(@station, station_name)
     @journeys << current_journey
  end

  def change_station(station_name)
    @station = station_name
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
