class Oystercard

MAXIMUM_TOPUP = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(cash)
    raise "Maximum limit is 90 pounds" if reached_max?(cash)
    @balance += cash
  end

  def deduct(cash)
    @balance -= cash
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
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

end
