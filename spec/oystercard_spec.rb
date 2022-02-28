require 'oystercard'

describe Oystercard do
  it 'New card instance has a balance of 0' do
    expect(subject.balance).to eq 0
  end
end