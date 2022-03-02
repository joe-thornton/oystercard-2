require_relative 'journey'

class Oystercard
  attr_accessor :balance, :journey_list, :journey

  MAX_BALANCE = 90
  MIN_JOURNEY_BALANCE = 1
  MIN_JOURNEY_FEE = 1

  def initialize(balance =0)
    @balance = balance #oystercard class
    @journey_list = []
  end

  def top_up_card(amount)
    check_top_up_doesnt_exceed_max_balance(amount)
    @balance += amount
  end

  def touch_in(station)#receive station from journey class
    reject_card_if_insufficient_funds_for_journey
    @journey = Journey.new(station)
    @journey_list << @journey
  end

  def touch_out(station) # receive station from journey class
    @journey.exit_station(station)
    deduct(@journey.calculate_fare)
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
