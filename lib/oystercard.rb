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
    deduct if @journey_log.current_journey != nil
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    deduct

    # @current_journey == nil ? didnt_touch_in(station) : did_touch_in(station)
    # @journeys << @current_journey
    # @current_journey = nil
  end



  private

  def deduct
    @balance -= @journey_log.current_journey.fare
  end

  # def didnt_touch_in(end_station)
  #   @current_journey = Journey.new(nil)
  #   @current_journey.end_journey(end_station)
  #   deduct(@current_journey.fare)
  # end
  #
  # def did_touch_in(end_station)
  #   @current_journey.end_journey(end_station)
  #   deduct(@current_journey.fare)
  # end

end
