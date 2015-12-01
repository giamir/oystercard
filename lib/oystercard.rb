class Oystercard
  attr_reader :balance, :in_journey
  alias_method :in_journey?, :in_journey

  MAX_BALANCE = 90

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
    @in_journey = true
  end

  private

  def exceed_limit?(amount)
    balance + amount > MAX_BALANCE
  end
end
