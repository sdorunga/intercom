class Customer
  attr_reader :id, :name, :location

  def initialize(id:, name:, location:)
    @id = id
    @name = name
    @location = location
  end

  def within(distance:, to:)
    @location.distance_to(to) <= distance.to_f
  end

  def to_s
    "#{id} -- #{name}"
  end
end
