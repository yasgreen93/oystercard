class Oystercard
  MAX_LIMIT = 90
  MIN_LIMIT = 1
  MIN_FARE = 1
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up cash
    within_limit(cash)
    @balance += cash
  end

  def in_journey?
    @entry_station != nil ? true : false
  end

  def touch_in(station)
     insufficient_funds
     @entry_station = station
  end

  def touch_out
    deduct(MIN_FARE)
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

end
