require 'oystercard'

describe Oystercard do
  it 'New card instance has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'Oystercard to be topped up by £5' do
    subject.top_up_card(5)
    expect(subject.balance).to eq 5
  end
  
  it 'raises an error when top-up takes balance over £90' do
    max_balance = Oystercard::MAX_BALANCE
    subject.top_up_card(max_balance)
    error_message = "Top-up unsuccessful - balance cannot exceed £#{max_balance}"
    expect { subject.top_up_card(1) }.to raise_error error_message
  end
  
end
