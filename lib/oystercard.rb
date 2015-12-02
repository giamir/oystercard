require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :journeys

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    self.balance = 0
    self.journeys = []
  end

  def top_up(amount)
    fail "exceeded max balance of #{MAX_BALANCE}" if exceed_limit?(amount)
    self.balance += amount
  end

  def touch_in(station)
    fail 'insufficient funds' if insufficient_balance?
    if !journeys.empty? && !journeys.last.complete?
      journeys.last.exit
      deduct(journeys.last.fare)
    end
    journeys << Journey.new(station)
  end

  def touch_out(station)
    if journeys.empty? || journeys.last.complete?
      journey = Journey.new
      journey.exit station
      deduct(journey.fare)
      journeys << journey
    else
      journeys.last.exit station
      deduct(journeys.last.fare)
    end
  end

  private

  attr_writer :balance, :journeys

  def deduct(amount)
    @balance -= amount
  end

  def exceed_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def insufficient_balance?
    balance < MIN_FARE
  end
end
