class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90
  MAX_ERROR = "Top up exceeds card's maximum balance of £#{MAX_BALANCE}."

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise MAX_ERROR if @balance + amount > 90
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
