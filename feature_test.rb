require './lib/oystercard.rb'

oystercard = Oystercard.new

oystercard.top_up(5)

oystercard.touch_in

oystercard.touch_in(station_name)
