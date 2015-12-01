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
      msg = "exceeded max balance of #{max}"
      oystercard.top_up max
      expect { oystercard.top_up 1 }.to raise_error msg
    end
  end

  describe '#deduct' do
    it 'deducts money from balance' do
      oystercard.top_up 1
      expect { oystercard.deduct 1 }.to change { oystercard.balance }.by(-1)
    end
  end

  describe '#touch_in' do
    it 'change the status of in_journey to true' do
      oystercard.top_up 10
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'change the status of in_journey to false' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).to_not be_in_journey
    end
  end
end
