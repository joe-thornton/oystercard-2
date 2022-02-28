class Oystercard
  attr_accessor :balance

  MAX_BALANCE = 90

  def initialize(balance =0)
    @balance = balance

  end

  def top_up_card(amount)
    check_top_up_doesnt_exceed_max_balance(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private

  def check_top_up_doesnt_exceed_max_balance(amount)
    raise "Top-up unsuccessful - balance cannot exceed £#{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE 
  end

end
