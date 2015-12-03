require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

class Oystercard
  attr_reader :balance, :log

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(journey_log_klass: JourneyLog.new)
    self.balance = 0
    self.log = journey_log_klass
  end

  def top_up(amount)
    fail "exceeded max balance of #{MAX_BALANCE}" if exceed_limit?(amount)
    self.balance += amount
  end

  def touch_in(station)
    fail 'insufficient funds' if insufficient_balance?
    deduct(log.outstanding_charges)
    log.start_journey(station)
  end

  def touch_out(station)
    deduct(log.exit_journey(station).fare)
  end

  private

  attr_writer :balance, :log

  def deduct(amount)
    self.balance -= amount
  end

  def exceed_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def insufficient_balance?
    balance < MIN_FARE
  end
end
