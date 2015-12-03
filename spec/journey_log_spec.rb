require 'journey_log'

describe JourneyLog do
  let(:journey) { double :journey }
  let(:station) { double :station }
  let(:journey_klass) { double :journey_klass, new: journey }
  subject(:log) { described_class.new(journey_klass) }

  describe '#start_journey' do
    it 'starts a journey' do
      expect(journey_klass).to receive(:new).with(station)
      log.start_journey(station)
    end
    it 'records a journey' do
      allow(journey_klass).to receive(:new).and_return journey
      log.start_journey(station)
      expect(log.journeys).to include journey
    end
  end

  describe '#current_journey' do
  end

  describe '#exit_journey' do
  end

  describe '#outstanding_charges' do
  end

  describe '#journeys' do
    it 'has an empty list of journeys by default' do
      expect(log.journeys).to be_empty
    end

    xit 'should return a list of all previous journeys' do
      # log.start_journey(entry_station)
      # log.exit_journey(exit_station)
      # expect(log.journeys).to eq
    end
  end

end
