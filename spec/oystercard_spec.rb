require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }


  it 'has an empty list of journeys by default' do
    expect(oystercard.journeys).to be_empty
  end

  describe '#balance' do
    it 'shows the card balance' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'can top up the balance' do
      expect { oystercard.top_up 1 }.to change { oystercard.balance }.by 1
    end
    it 'fails if new balance exceeds max balance' do
      max = described_class::MAX_BALANCE
      msg = "exceeded max balance of #{max}"
      oystercard.top_up max
      expect { oystercard.top_up 1 }.to raise_error msg
    end
  end

  describe '#touch_in' do
    it 'prevents touch in when card has insufficient funds' do
      msg = 'insufficient funds'
      expect { oystercard.touch_in(entry_station) }.to raise_error msg
    end
    it 'ensures card remembers the entry_station when you touch in' do
      oystercard.top_up described_class::MIN_FARE
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end
  end

  describe '#touch_out' do
    before do
      oystercard.top_up described_class::MIN_FARE
      oystercard.touch_in(entry_station)
    end
    it { is_expected.to respond_to(:touch_out).with(1).argument }
    it 'deduct the balance by minimum fare' do
      min = described_class::MIN_FARE
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by(-min)
    end
    it 'makes card forget entry_station when you touch out' do
      oystercard.touch_out(exit_station)
      expect(oystercard.entry_station).to be_nil
    end
    it 'stores exit station' do
      oystercard.touch_out(exit_station)
      expect(oystercard.exit_station).to eq exit_station
    end
  end

  describe '#in_journey?' do
    it 'returns status of journey' do
      expect(oystercard.in_journey?).to be false
    end
  end

  context 'after a journey' do
    it 'checks that touching in and out log the journey' do
      oystercard.top_up described_class::MIN_FARE
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys).to include journey
    end
  end
end
