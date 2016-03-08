require_relative 'station'

class Oystercard
  MAX_LIMIT = 90
  MIN_LIMIT = 1
  MIN_FARE = 1
  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up cash
    within_limit(cash)
    @balance += cash
  end

  def in_journey?
    @entry_station != nil ? true : false
  end

  def touch_in(entry_station)
     insufficient_funds
     @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @exit_station = exit_station
    record_journey
    @entry_station = nil
  end

  private
  def within_limit(cash)
    message = "Limit of #{MAX_LIMIT} exceeded"
    raise message if (balance + cash) > MAX_LIMIT
  end

  def insufficient_funds
    message = "You have an insufficicent balance"
    raise message if balance < MIN_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end

  def record_journey
    journey = {:entry_station=> @entry_station, :exit_station => @exit_station}
    @journeys << journey
  end

end
