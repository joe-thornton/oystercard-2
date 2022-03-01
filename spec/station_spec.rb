require 'station'

describe Station do
  
  subject {Station.new('waterloo', 2)}
  
  it 'creating a new instance of station should initialise the instance with a zone' do
    expect(subject.zone).to eq 2
  end

  it 'creating a new instance of station should initialise the instance with a station name' do
    expect(subject.station_name).to eq 'waterloo'
  end 
end