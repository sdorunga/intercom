require "bigdecimal"
require "forwardable"

class Point
  extend Forwardable
  def_delegators Math, :sin, :cos, :atan2, :sqrt, :acos, :asin
  EARTH_RADIUS_KM = 6371
  RADIAN_PER_DEGREE = Math::PI / 180

  def initialize(lat:, long:)
    @lat = BigDecimal.new(lat, 15)
    @long = BigDecimal.new(long, 15)

    if !(-90..90).include?(@lat) || !(-180..180).include?(@long)
      raise ArgumentError.new("Invalid lat, long values, correct ranges are from -90..90 for lat and -180..180 for long") end
  end

  def distance_to(to)
    delta_lat = to.lat - lat
    delta_long = to.long - long

    central_angle = 2 * asin(sqrt(sin(delta_lat/2)**2 +
                                  cos(lat) * cos(to.lat) * sin(delta_long/2)**2))
    (central_angle * EARTH_RADIUS_KM).round(2)
  end

  def ==(other)
    other.lat == lat && other.long == long
  end

  protected

  def lat
    radian(@lat)
  end

  def long
    radian(@long)
  end

  def radian(angle)
    angle * RADIAN_PER_DEGREE
  end
end
