require 'oystercard'

describe Oystercard do

  subject(:oystercard) {described_class.new}

  describe '#balance' do

    it 'shows the card balance' do
      expect(oystercard.balance).to eq 0
    end
  end

end
