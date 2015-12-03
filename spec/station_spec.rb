require 'spec_helper'
require 'station'

describe Station do
  # subject(:station) { described_class.new(name: 'Aldgate East', zone: 3) }
  subject(:station) { described_class.new('Aldgate', 3) }
  it 'shows the name of the station' do
    expect(station.name).to eq 'Aldgate'
  end
  it 'shows the zone of the station' do
    expect(station.zone).to eq 3
  end
end
