require 'forwardable'
class JourneyLog
  extend Forwardable

  def_delegator :current_journey, :exit, :exit_journey

  NO_CHARGE = 0

  def initialize(journey_klass = Journey)
    self.journey_klass = journey_klass
    self.journeys = []
  end

  def start_journey(station)
    add(journey_klass.new station)
  end

  # don't need anymore cause we use def_delegator
  # def exit_journey(station)
  #   current_journey.exit(station)
  # end

  def outstanding_charges
    incomplete_journey ? incomplete_journey.exit.fare : NO_CHARGE
  end

  def journeys
    @journeys.dup
  end

  private

  attr_writer :journeys
  attr_accessor :journey_klass

  def current_journey
    incomplete_journey || journey_klass.new
  end

  def incomplete_journey
    journeys.last && !journeys.last.complete? ? journeys.last : nil
  end

  def add(journey)
    @journeys << journey
  end
end
