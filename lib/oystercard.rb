require_relative 'journey'

class Oystercard

  attr_reader :balance, :trip_history, :journey

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @trip_history = []
    @journey
  end

  def top_up(value)
    raise Exception.new "Top-up failed - Balance exceeding £90" if exceeds_limit?(value)

    @balance += value
  end

  def in_journey?
    !!@journey
  end

  def touch_in(station)
    no_touch_out?
    raise Exception.new "Sorry, insufficient funds." if insufficient_funds?
    @journey = Journey.new(station)
  end

  def touch_out(station)
    no_touch_in?(station)
    @journey.finish(station)
    deduct(@journey.fare)
    add_trip
    @journey = nil
  end

  private

  def exceeds_limit?(value)
    @balance + value > MAX_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def deduct(value)
    @balance -= value
  end

  def add_trip
    @trip_history << @journey
  end

  def no_touch_out?
    if !!@journey
      add_trip if !!@journey
      deduct(@journey.fare)
    end
  end

  def no_touch_in?(station)
    if !@journey
      @journey = Journey.new(nil, station)
      add_trip
    end
  end

end
