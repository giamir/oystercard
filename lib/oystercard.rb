class Oystercard
  attr_reader :balance, :in_journey
  alias_method :in_journey?, :in_journey

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "exceeded max balance of #{MAX_BALANCE}" if exceed_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail 'insufficient funds' if insufficient_balance?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def exceed_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def insufficient_balance?
    balance < MIN_FARE
  end
end
