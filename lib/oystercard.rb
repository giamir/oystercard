class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    msg = "cannot top up, card limit of #{MAX_LIMIT} has been exceeded"
    fail msg if exceed_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    fail 'cannot deduct, not enough credit' if amount_more_than_balance?(amount)
    @balance -= amount
  end

  private

  def exceed_limit?(amount)
    balance + amount > MAX_LIMIT
  end

  def amount_more_than_balance?(amount)
    amount > balance
  end
end
