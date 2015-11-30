
require_relative './lib/oystercard.rb'

card = Oystercard.new
p card.balance
p card.top_up(10)
p card.balance
p card.top_up(81)
p card.balance
p card.deduct(20)
p card.balance
p card.deduct(100)
p card.balance
