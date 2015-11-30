class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "cannot top up, card limit of #{MAX_LIMIT} has been exceeded" if exceed_limit?(amount)
    @balance += amount
  end

  private

  def exceed_limit?(amount)
    balance + amount > MAX_LIMIT
  end
end
