class Oystercard

  attr_reader :balance

  MIN_BALANCE = 1
  MAX_BALANCE = 90
  MAX_ERROR = "Top up exceeds card's maximum balance of £#{MAX_BALANCE}."
  MIN_ERROR = "Cannot touch in if card's balance less than £#{MIN_BALANCE}"

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise MAX_ERROR if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in
    raise MIN_ERROR if @balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MIN_BALANCE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
