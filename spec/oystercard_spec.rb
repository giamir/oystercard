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
      max = described_class::MAX_LIMIT
      oystercard.top_up max
      msg = "cannot top up, card limit of #{max} has been exceeded"
      expect { oystercard.top_up 1 }.to raise_error msg
    end
  end
  describe '#deduct' do
    it 'can deduct the balance' do
      oystercard.top_up 1
      expect { oystercard.deduct 1 }.to change { oystercard.balance }.by(-1)
    end
    it 'prevents deduct when amount is more than credit' do
      msg = 'cannot deduct, not enough credit'
      expect { oystercard.deduct 1 }.to raise_error msg
    end
  end
end
