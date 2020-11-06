class Journey

  SINGLE_JOURNEY_FARE = 1
  PENALTY_FEE = 6 # amount of penalty fee if no touch_in or touch_out in journey

  attr_reader :entry_station, :exit_station, :complete

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @complete = false
  end

  def fare
    complete? ? SINGLE_JOURNEY_FARE : PENALTY_FEE
  end

  def finish(station)
    @exit_station = station
    @complete = true
  end

  private

  def complete?
    @complete
  end

end