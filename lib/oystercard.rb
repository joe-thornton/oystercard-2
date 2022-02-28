class Oystercard
  attr_accessor :balance, :entry_station

  MAX_BALANCE = 90
  MIN_JOURNEY_BALANCE = 1
  MIN_JOURNEY_FEE = 1

  def initialize(balance =0)
    @balance = balance
    @entry_station = nil
  end

  def top_up_card(amount)
    check_top_up_doesnt_exceed_max_balance(amount)
    @balance += amount
  end

  def in_journey? 
    !!@entry_station
  end

  def touch_in(station)
    reject_card_if_insufficient_funds_for_journey
    @entry_station = station
  end

  def touch_out
    # atm below has a set fee for jouneys
    deduct(MIN_JOURNEY_FEE)
    @entry_station = nil
  end

  private

  def check_top_up_doesnt_exceed_max_balance(amount)
    raise "Top-up unsuccessful - balance cannot exceed £#{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE 
  end

  def reject_card_if_insufficient_funds_for_journey
    raise "Insufficient balance for journey" if @balance < MIN_JOURNEY_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

end
