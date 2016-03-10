require_relative 'journey'
class JourneyLog

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
  end

  def list_journeys
    @journeys.dup
  end

  def start(entry_station)
    create_journey(entry_station)
    log_journey
  end

  def finish(exit_station)
    create_journey(nil) if not_touched_in?
    @current_journey.end_journey(exit_station)
    log_journey
    @current_journey = nil
  end

  private

  def create_journey(entry_station)
    @current_journey = @journey_class.new(entry_station)
  end

  def log_journey
    @journeys.pop if @current_journey.exiting?
    @journeys << @current_journey
  end

  def not_touched_in?
    @current_journey == nil
  end

  def current_journey
  end

end
