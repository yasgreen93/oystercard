
class JourneyLog

  def initialize(journey_class)
    @journey_class = journey_class
    @current_journey = nil
    @journeys = []
  end

  def list_journeys
    @journey.dup
  end

  def start(start_station)
    @current_journey = @journey_class.new(start_station)
    @journeys << @current_journey
  end

  def finish(end_station)
    @journeys.pop
    @current_journey.add_exit_station(end_station)
    @journeys << @current_journey
    @current_journey = nil
  end

  private

  def current_journey
    @current_journey || journey_class.new
  end

end
