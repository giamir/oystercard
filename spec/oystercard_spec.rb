require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) { double(:journey) }

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

    it 'stores in journeys a starting journey' do
      oystercard.top_up described_class::MIN_FARE
      expect{oystercard.touch_in(entry_station)}.to change {oystercard.journeys.size}.by 1
    end

    it 'deduct the penalty fare if you didnt touch out' do

      oystercard.top_up(50)
      oystercard.touch_in(entry_station)
      oystercard.touch_in(entry_station)
      expect(oystercard.balance).to eq 44
    end

  end

  describe '#touch_out' do

    it 'deduct the penalty fare if you touch out without touching in' do
      oystercard.touch_out(exit_station)
      expect(oystercard.balance).to eq(-6)
    end

    it 'completes last journey' do
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys.last.complete).to be true
    end
  end

  describe 'after a journey' do
    it 'deducts minimum fare' do
      oystercard.top_up(50)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.balance).to eq 43
    end
  end

end
