require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }

  describe '#start' do
    it 'store the entry_station' do
      journey.start(entry_station)
      expect(journey.entry_station).to eq entry_station
    end
  end

  describe '#end' do
    it 'store the exit_station' do
      journey.end(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

  describe '#fare' do
  end
end
