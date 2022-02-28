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

  it 'oystercard to respond to in journey' do
    expect(subject).to respond_to(:in_journey?)
  end

  it 'when new oystercard instance is initialised it will not be in_journey' do
    expect(subject).to_not be_in_journey
  end

  it 'refuses entry if balance is below min journey balance' do
    expect { subject.touch_in }.to raise_error "Insufficient balance for journey"    
  end
  
  context 'oystercard balance has sufficient journey funds' do
    before(:each) do
      subject.balance = 5
    end

    it 'oystercard touch_in changes in_journey? to true' do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'oystercard touch_out after touching in returns in_journey? to false' do
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end

    it 'oystercard touching out reduces the balance of the oystercard by minimum journey fee' do
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MIN_JOURNEY_FEE)
    end
  end 
 
end
