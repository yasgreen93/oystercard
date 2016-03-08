require './lib/oystercard.rb'
require './lib/station.rb'

oystercard = Oystercard.new

oystercard.top_up(50)

oystercard.touch_in('pepper station')
oystercard.touch_out('im hungry staton')

p oystercard.balance

aldgate = Station.new :aldgate, 1

oystercard.touch_in(aldgate)

p oystercard

list = {oxfordcircus: 1,
liverpoolstreet: 1,
hackney: 2}

station_instances_hash = Hash.new

list.each do |key, value|
    station_instances_hash[key] = Station.new(key.to_sym, value)
end

p station_instances_hash

test_journey = Journey.new (station1, station2)

oystercard.touch_in(:oxfordcircus)
oystercard.touch_out(:hackney)
