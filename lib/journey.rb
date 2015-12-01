class Journey
  attr_reader :entry_station, :exit_station

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end
end
