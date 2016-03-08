class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90
  MAX_ERROR = "Top up exceeds card's maximum balance of £#{MAX_BALANCE}."

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise MAX_ERROR if @balance + amount > 90
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
