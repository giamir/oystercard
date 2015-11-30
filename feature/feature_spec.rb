
require_relative '../lib/oystercard.rb'
# In order to use public transport
# As a customer
# I want money on my card
card = Oystercard.new
p card.balance
p card.top_up(10)
p card.balance
