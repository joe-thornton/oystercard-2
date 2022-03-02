require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  let(:tapped_in_journey) { double(:journey, entry_station: entry_station)}
  let(:complete_journey) { double(:journey, entry_station: entry_station, exit_station: exit_station) }
  
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

  it 'refuses entry if balance is below min journey balance' do
    expect { subject.touch_in(entry_station) }.to raise_error "Insufficient balance for journey"
  end
  
  it 'creates an empty journey list upon initializing new oystercard' do
    expect(subject.journey_list).to be_empty
  end

  context 'oystercard balance has sufficient journey funds' do
    before(:each) do
      subject.balance = 5
    end

    it 'oystercard touching out reduces the balance of the oystercard by journey fare' do
        subject.journey = tapped_in_journey
        allow(subject.journey).to receive(:exit_station).and_return(complete_journey)
        allow(subject.journey).to receive(:calculate_fare).and_return(1)
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-1)
    end

    # HAVE STUBBED OUT NEW_JOURNEY(STATION) - IS THAT OKAY? THAT BEHAVIOUR SHOULD BE BEING TESTED IN THE JOURNEY SPEC?
    it 'tests that touch_in adds a journey to the journey_list' do
      allow(Journey).to receive(:new).and_return(tapped_in_journey)
      subject.touch_in(entry_station)
      expect(subject.journey_list).to eq([tapped_in_journey])
    end

  end 

end
