class Oystercard
  MAX_LIMIT = 90
  MIN_LIMIT = 1
  MIN_FARE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up cash
    within_limit(cash)
    @balance += cash
  end

  def in_journey?
    @in_journey
  end

  def touch_in
     insufficient_funds
    @in_journey = true
  end

  def touch_out
    deduct(MIN_FARE)
    @in_journey = false
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
