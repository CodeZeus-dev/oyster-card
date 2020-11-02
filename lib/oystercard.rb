class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(value)
    raise Exception.new "Top-up failed - Balance exceeding £90" if exceeds_limit?

    @balance += value
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise Exception.new "Sorry, insufficient funds." if insufficient_funds?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct
  end

  private

  def exceeds_limit?
    @balance >= MAX_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def deduct
    @balance -= MINIMUM_FARE
  end

end
