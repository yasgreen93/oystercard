class Oystercard

  attr_reader :balance, :entry_station, :journeys
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
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_BALANCE)
    journey = {}
    journey[:entry_station] = @entry_station
    journey[:exit_station] = station
    p journey
    @journeys << journey
    p @journeys
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
