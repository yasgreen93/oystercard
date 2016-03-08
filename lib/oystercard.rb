class Oystercard

MAXIMUM_TOPUP = 90
MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(cash)
    raise "Maximum limit is #{MAXIMUM_TOPUP} pounds" if reached_max?(cash)
    @balance += cash
  end

  def touch_in
    raise "Insufficient balance to touch in." if not_enough?
    @in_journey = true
  end

  def touch_out
    deduct MINIMUM_FARE
    @in_journey = false
  end

  attr_reader :balance

  def in_journey?
    @in_journey
  end

private

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
