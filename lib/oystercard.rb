class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :trip_history

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @trip_history = []
  end

  def top_up(value)
    raise Exception.new "Top-up failed - Balance exceeding £90" if exceeds_limit?(value)

    @balance += value
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    raise Exception.new "Sorry, insufficient funds." if insufficient_funds?
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    raise Exception.new "You need to touch in first!" if !@entry_station
    @exit_station = exit_station
    trip_history << { entry_station: @entry_station, exit_station: @exit_station }
    @entry_station = nil
    deduct
  end

  private

  def exceeds_limit?(value)
    @balance + value > MAX_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def deduct
    @balance -= MINIMUM_FARE
  end

end
