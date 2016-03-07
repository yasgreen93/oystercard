class Oystercard
  MAX_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up cash
    within_limit(cash)
    @balance += cash
  end

  def within_limit(cash)
    message = "Limit of #{MAX_LIMIT} exceeded"
    raise message if (balance + cash) > MAX_LIMIT
  end
end
