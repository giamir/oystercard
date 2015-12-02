class Journey
  attr_reader :entry_station, :exit_station, :complete
  alias_method :complete?, :complete

  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    self.entry_station = entry_station
    self.complete = false
  end

  def exit(exit_station = nil)
    self.exit_station = exit_station
    self.complete = true
    self
  end

  def fare
    return PENALTY_FARE if penalty?
    1
  end

  private

  attr_writer :entry_station, :exit_station, :complete

  def penalty?
    (!entry_station || !exit_station)
  end
end
