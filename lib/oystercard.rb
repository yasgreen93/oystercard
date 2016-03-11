require_relative 'journey'
require_relative 'journeylog'

class Oystercard

  attr_reader :balance
  MIN_BALANCE = 1
  MAX_BALANCE = 90
  MAX_ERROR = "Top up exceeds card's maximum balance of £#{MAX_BALANCE}."
  MIN_ERROR = "Cannot touch in if card's balance less than £#{MIN_BALANCE}"

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new(Journey) #=> MORE INDEPENDENCY
  end

  def top_up(amount)
    raise MAX_ERROR if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise MIN_ERROR if @balance < MIN_BALANCE
    no_touch_out
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    deduct
    @journey_log.reset
  end



  private

  def no_touch_out
    if @journey_log.current_journey != nil
      deduct
      @journey_log.no_touch_out
    end
  end

  def deduct
    @balance -= @journey_log.current_journey.fare
  end

end
