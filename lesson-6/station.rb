require_relative 'validator'

class Station
  include Validator
  attr_reader :trains

  @stations = []

  def self.add(station)
    @stations << station
  end

  def self.all
    @stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.send :add, self
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    types = { cargo: 'CargoTrain', passenger: 'PassengerTrain' }
    @trains.select { |train| types[type.to_sym] == train.class.to_s }
  end

  def remove_train(train)
    @trains.delete(train)
  end

  private

  def validate!
    raise "Name can't be empty" if @name.to_s.empty?
    true
  end

  private_class_method :add
end
