class JourneyLog
  attr_reader :journey_klass, :journeys

  def initialize(journey_klass:)
    @journey_klass = journey_klass
    @journeys = []
  end

  def start_journey(entry_station:)
    journeys << (journey_klass.new entry_station)
  end

  # def incomplete_journey
  #   !journeys.last.complete? ? journeys.last : nil
  # end
end
