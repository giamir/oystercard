require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

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
    handle_double_touch_in if double_touch_in?
    add_journey station
  end

  def touch_out(station)
    add_journey if missing_touch_in?
    complete_journey station
    deduct(appropriate_fare)
  end

  private

  attr_writer :balance, :journeys

  def double_touch_in?
    !journeys.empty? && !journeys.last.complete?
  end

  def handle_double_touch_in
    journeys.last.exit
    deduct(appropriate_fare)
  end

  def add_journey(station = nil)
    journeys << Journey.new(station)
  end

  def missing_touch_in?
    journeys.empty? || journeys.last.complete?
  end

  def complete_journey(station)
    journeys.last.exit(station)
  end

  def appropriate_fare
    journeys.last.fare
  end

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
