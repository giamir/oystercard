require 'station'

describe Station do
  let(:name) { 'Aldgate' }
  let(:zone) { 3 }
  # subject(:station) { described_class.new(name: 'Aldgate East', zone: 3) }
  subject(:station) { described_class.new(name, zone) }
  it 'shows the name of the station' do
    expect(station.name).to eq 'Aldgate'
  end
  it 'shows the zone of the station' do
    expect(station.zone).to eq 3
  end
end
