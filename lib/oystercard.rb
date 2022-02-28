class Oystercard
  attr_accessor :balance

  def initialize(balance =0)
    @balance = balance
  end

  def top_up_card(amount)
    @balance += amount
  end

end
