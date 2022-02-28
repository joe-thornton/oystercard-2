class Oystercard
  attr_accessor :balance, :entry_station
  attr_reader :journey_list

  MAX_BALANCE = 90
  MIN_JOURNEY_BALANCE = 1
  MIN_JOURNEY_FEE = 1

  # Notes on how we might added hashes for journeys:
  # DONE - Initialize an empty array for list of journey
  # Shovel a hash with entry station
  # When we touch out, we append the last hash (using .store)
  # Refactor to remove instance variables (included in_journey?)

  def initialize(balance =0)
    @balance = balance
    @entry_station = nil
    @journey_list = []
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
    # @journey_list << {entry_station: station}
  end

  def touch_out(station)
    # atm below has a set fee for jouneys
    deduct(MIN_JOURNEY_FEE)
    add_journey_to_journey_list(station)
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

  def add_journey_to_journey_list(station)
    @journey_list << {entry_station: @entry_station, exit_station: station}
  end

end
