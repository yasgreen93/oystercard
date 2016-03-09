
class JourneyLog

  def initialize(journey_class)
    @journey_class = journey_class
    @current_journey = nil
    @journeys = []
  end

  def list_journeys
    @journeys.dup
  end

  def start(start_station)
    @current_journey = @journey_class.new(start_station)
    log_journey
  end

  def finish(end_station)
    @current_journey.add_exit_station(end_station)
    log_journey
    @current_journey = nil
  end

  private

  def current_journey
    @current_journey || journey_class.new
  end

  def log_journey
    @journeys.pop if @current_journey.exiting?
    @journeys << @current_journey
  end

end
