require 'spec_helper'
require 'journey_log'

describe JourneyLog do
  let(:journey) { double :journey }
  let(:station) { double :station }
  let(:journey_klass) { double :journey_klass, new: journey }
  subject(:log) { described_class.new(journey_klass) }

  describe '#start_journey' do
    it 'creates a journey' do
      expect(journey_klass).to receive(:new).with(station)
      log.start_journey(station)
    end
    it 'records a journey' do
      log.start_journey(station)
      expect(log.journeys).to include journey
    end
  end

  describe '#exit_journey' do
    it 'adds a new exit station to the current journey' do
      expect(journey).to receive(:exit).with(station)
      log.exit_journey(station)
    end
  end

  describe '#outstanding_charges' do
    it 'returns the fare an incomplete journey' do
      log.start_journey(station)
      allow(journey).to receive(:complete?).and_return(false)
      allow(journey).to receive(:exit).and_return(journey)
      expect(journey).to receive(:fare)
      log.outstanding_charges
    end
  end

  describe '#journeys' do
    it 'has an empty list of journeys by default' do
      expect(log.journeys).to be_empty
    end

    it 'should return a list of all previous journeys' do
      log.start_journey(station)
      allow(journey).to receive(:complete?).and_return(false)
      allow(journey).to receive(:exit)
      log.exit_journey(station)
      expect(log.journeys).to eq [journey]
    end
  end
end
