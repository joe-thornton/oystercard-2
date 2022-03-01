class Oystercard
  attr_accessor :balance
  attr_reader :journey_list

  MAX_BALANCE = 90
  MIN_JOURNEY_BALANCE = 1
  MIN_JOURNEY_FEE = 1

  def initialize(balance =0)
    @balance = balance
    @journey_list = []
  end

  def top_up_card(amount)
    check_top_up_doesnt_exceed_max_balance(amount)
    @balance += amount
  end

  def in_journey?
    @journey_list.empty? ? false : !@journey_list.last.has_key?(:exit_station)
  end

  def touch_in(station)
    reject_card_if_insufficient_funds_for_journey
    @journey_list << {entry_station: station}
  end

  def touch_out(station)
    deduct(MIN_JOURNEY_FEE)
    @journey_list.last.merge!({exit_station: station})
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
