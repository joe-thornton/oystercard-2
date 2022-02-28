require 'oystercard'

describe Oystercard do
  it 'New card instance has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'Oystercard to be topped up by £5' do
    subject.top_up_card(5)
    expect(subject.balance).to eq 5
  end

  
end
