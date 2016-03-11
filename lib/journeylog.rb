require_relative 'journey'

class JourneyLog

  def initialize(journey_class)
    @journey_class = journey_class
    @current_journey = nil
  end

  def start(station)
    @current_journey = @journey_class.new(station)

  end

  def finish(station)
    @current_journey.end_journey(station)
  end


end
