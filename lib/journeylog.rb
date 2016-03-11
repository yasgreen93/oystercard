require_relative 'journey'

class JourneyLog

  attr_reader :current_journey

  def initialize(journey_class)
    @journey_class = journey_class
    @current_journey = nil
    @journeys = []
  end

  def start(station)
    @current_journey = @journey_class.new(station)
  end

  def finish(station)
    no_touch_in
    @current_journey.end_journey(station)
    log
  end

  def journeys
    @journeys.dup
  end

  def reset
    @current_journey = nil
  end

  def no_touch_out
    log
    reset
  end

  private
    def no_touch_in
      @current_journey ||= @journey_class.new(nil)
    end

    def log
      @journeys << @current_journey
    end

end
