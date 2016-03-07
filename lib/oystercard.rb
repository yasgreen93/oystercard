class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Top up exceeds card's maximum balance." if @balance + amount > 90
    @balance += amount
  end

  def max_balance
    MAX_BALANCE
  end

end
