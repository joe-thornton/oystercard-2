class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def in_journey? #journey class
    @exit_station.nil?
  #   @journey_list.empty? ? false : !@journey_list.last.has_key?(:exit_station)
  end

  def exit_station(exit_station)
    @exit_station = exit_station
  end

  def is_journey_complete?
    !@exit_station.nil?
  end

  def calculate_fare
    is_journey_complete? ? 1 : 10
  end

end
