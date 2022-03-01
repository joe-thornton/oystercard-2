require 'journey'

describe Journey do
  subject { Journey.new('waterloo') }

  it 'journey to respond to in_journey?' do
    expect(subject).to respond_to(:in_journey?)
  end

  it 'when new journey instance is initialised it will be in_journey?' do
    expect(subject).to be_in_journey
  end

  it 'providing exit station returns in_journey? to false' do
    subject.exit_station('baker street')
    expect(subject).to_not be_in_journey
  end

  it 'jouney should return true when journey is complete' do
    subject.exit_station('baker street')
    expect(subject).to be_is_journey_complete
  end

  it 'when journey is complete, calculate the fare as £1' do
    subject.exit_station('baker street')  
    expect(subject.calculate_fare).to eq 1
  end

  it 'when journey is incomplete calculate the fare as £10' do
    expect(subject.calculate_fare).to eq 10
  end

end