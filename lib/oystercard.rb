require_relative 'journey'

class Oystercard

  attr_reader :balance, :journeys
  MIN_BALANCE = 1
  MAX_BALANCE = 90
  MAX_ERROR = "Top up exceeds card's maximum balance of £#{MAX_BALANCE}."
  MIN_ERROR = "Cannot touch in if card's balance less than £#{MIN_BALANCE}"

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise MAX_ERROR if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise MIN_ERROR if @balance < MIN_BALANCE
    deduct(@current_journey.fare) if @current_journey != nil
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    # If current_journey = nil, create new journey
    if @current_journey == nil
      @current_journey = Journey.new(nil)
      @current_journey.end_journey(station)
      deduct(@current_journey.fare)
    else
      @current_journey.end_journey(station)
      deduct(@current_journey.fare)
    end
    @journeys << @current_journey
    @current_journey = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
