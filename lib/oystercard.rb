class Oystercard

MAXIMUM_TOPUP = 90
MINIMUM_FARE = 1

  def initialize
    @station = nil
    @balance = 0
  end

  def top_up(cash)
    raise "Maximum limit is #{MAXIMUM_TOPUP} pounds" if reached_max?(cash)
    @balance += cash
  end

  def touch_in(station_name)
    raise "Insufficient balance to touch in." if not_enough?
    change_station(station_name)
  end

  def touch_out
    deduct MINIMUM_FARE
    change_station nil
  end

  attr_reader :balance, :station

  def in_journey?
    !@station.nil?
  end

private

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
