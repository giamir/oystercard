require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe '#balance' do
    it 'shows the card balance' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'adds funds to card' do
      amount = rand(100)
      oystercard.top_up(amount)
      oystercard.top_up(amount)
      expect(oystercard.balance).to eq amount * 2
    end
  end
end
