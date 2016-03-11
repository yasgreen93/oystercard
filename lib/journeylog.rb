require_relative 'journey'

class JourneyLog

  attr_reader :current_journey

  def initialize(journey_class)
    @journey_class = journey_class
    @current_journey = nil
  end

  def start(station)
    @current_journey = @journey_class.new(station)
  end

  def finish(station)
    current_journey
    @current_journey.end_journey(station)
    log
    reset
  end

  def journeys
    @journeys.dup
  end

  private
    def current_journey
      @current_journey ||= @journey_class.new(nil)
    end

    def log
      @journeys << @current_journey
    end

    def reset
      @current_journey = nil
    end
end
