class Oystercard

MAXIMUM_TOPUP = 90
MINIMUM_FARE = 1

  def initialize(journey_class)
    @station = nil
    @balance = 0
    @journeys = []
    @journey = journey_class.new(nil, nil)
  end

  def top_up(cash)
    raise "Maximum limit is #{MAXIMUM_TOPUP} pounds" if reached_max?(cash)
    @balance += cash
  end

  def touch_in(station_name)
    create_journey(station_name, nil) if same_station?(station_name)
    deduct(@journey.class::PENALTY_FARE) if same_station?(station_name)
    raise "Insufficient balance to touch in." if not_enough?
    change_station(station_name)
  end

  def touch_out(station_name)
    create_journey(@station, station_name)
    deduct(@journey.class::PENALTY_FARE) if @station == nil
    deduct MINIMUM_FARE unless @station == nil
    change_station nil
  end

  attr_reader :balance, :station, :journeys, :journey

  def in_journey?
    !@station.nil?
  end

private

  def create_journey(entry_station, exit_station)
     @journey.change_journey(entry_station, exit_station)
     @journeys << @journey
  end

  def change_station(station_name)
    @station = station_name
  end

  def same_station?(station_name)
    @station == station_name
  end

  def reached_max?(cash)
    @balance + cash > MAXIMUM_TOPUP
  end

  def not_enough?
    @balance < MINIMUM_FARE
  end

  def deduct(cash)
    @balance -= cash
  end

end
