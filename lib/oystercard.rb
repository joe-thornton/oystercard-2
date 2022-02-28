class Oystercard
  attr_accessor :balance

  MAX_BALANCE = 90
  MIN_JOURNEY_BALANCE = 1

  def initialize(balance =0)
    @balance = balance
    @in_journey = false
  end

  def top_up_card(amount)
    check_top_up_doesnt_exceed_max_balance(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey? 
    @in_journey
  end

  def touch_in
    reject_card_if_insufficient_funds_for_journey
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def check_top_up_doesnt_exceed_max_balance(amount)
    raise "Top-up unsuccessful - balance cannot exceed £#{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE 
  end

  def reject_card_if_insufficient_funds_for_journey
    raise "Insufficient balance for journey" if @balance < MIN_JOURNEY_BALANCE
  end

end
