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
    it 'prevents top_up when card reaches limit' do
      oystercard.top_up described_class::MAX_LIMIT
      expect { oystercard.top_up 1 }.to raise_error "cannot top up, card limit of #{described_class::MAX_LIMIT} has been exceeded"
    end

  end
end
