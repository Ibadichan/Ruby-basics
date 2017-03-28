require_relative('manufacturer')

class Train
  include Manufacturer

  attr_reader :number, :cars, :index
  attr_accessor :speed, :route

  @@trains = {}
  FORMAT_NUMBER = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @cars = []
    @index = 0
    @@trains[@number] = self
  end

  def self.find(number)
    @@trains[number]
  end

  def stop
    @speed = 0
  end

  def forward
    @index += 1 if can_next?
  end

  def backward
    @index -= 1 if @index > 0
  end

  def current_station
    @route.stations[@index]
  end

  def prev_station
    @route.stations[@index-1] if @index > 0
  end

  def next_station
    @route.stations[@index+1] if can_next?
  end

  def stopped?
    @speed == 0
  end

  def can_next?
    @index <= @route.stations.size
  end

  def add_car(car)
    @cars << car if valid_car_type?(car) &&  stopped?
  end

  def valid?
    validate!
  rescue => e
    puts e
    false
  end

  def each_car
    @cars.each do |car|
      yield(car)
    end
  end

  private

  def validate!
    raise 'number invalid ' if @number !~ FORMAT_NUMBER
    true
  end
end
