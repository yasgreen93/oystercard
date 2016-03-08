require './lib/oystercard.rb'

oystercard = Oystercard.new

oystercard.top_up(50)

oystercard.touch_in('pepper station')
oystercard.touch_out('im hungry staton')

p oystercard.journeys
p oystercard.balance

aldgate = Station.new
