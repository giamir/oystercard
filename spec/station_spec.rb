require 'station'

describe Station do
  subject(:station) { described_class.new(name: 'Aldgate East', zone: 3) }

  it 'gives you the name of the station' do
    expect(station.name).to eq 'Aldgate East'
  end
  it 'gives you the zone of the station' do
    expect(station.zone).to eq 3
  end
end
