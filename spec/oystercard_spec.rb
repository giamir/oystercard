require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

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
      oystercard.top_up max
      expect { oystercard.top_up 1}.to raise_error "exceeded max balance of #{max}"
    end
  end

  describe '#deduct' do
    it 'deducts money from balance' do
      oystercard.top_up 1
      expect { oystercard.deduct 1}.to change { oystercard.balance}.by -1
    end
  end
end
