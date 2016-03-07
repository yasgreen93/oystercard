class Oystercard

MAXIMUM_TOPUP = 90

  def initialize
    @balance = 0
  end

  def top_up(cash)
    raise "Maximum limit is 90 pounds" if reached_max?(cash)
    @balance += cash
  end

  attr_reader :balance

private

  def reached_max?(cash)
    @balance + cash > MAXIMUM_TOPUP
  end

end
