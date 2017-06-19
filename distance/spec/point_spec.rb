require "rspec"
require_relative "../lib/point"

RSpec.describe Point do
  let(:valid_lat) { 20.0 }
  let(:valid_long) { 100.0 }

  it "is not valid when initialized with invalid coordinates" do
    argument_error_message = "Invalid lat, long values, correct ranges are from -90..90 for lat and -180..180 for long"
    expect{Point.new(lat: -90.1, long: valid_long)}.to raise_error(ArgumentError, argument_error_message)
    expect{Point.new(lat: 90.1, long: valid_long)}.to raise_error(ArgumentError, argument_error_message) 
    expect{Point.new(lat: valid_lat, long: -180.1)}.to raise_error(ArgumentError, argument_error_message)
    expect{Point.new(lat: valid_lat, long: 180.1)}.to raise_error(ArgumentError, argument_error_message)
  end

  it "is is at zero distance from itself" do
    point = Point.new(lat: valid_lat, long: valid_long)

    expect(point.distance_to(point)).to eq(0.0)
  end

  it "its distances to both poles together should equal half the circumference of the earth" do
    point = Point.new(lat: valid_lat, long: valid_long)
    north_pole = Point.new(lat: 90, long: 0)
    south_pole = Point.new(lat: -90, long: 0)

    expect(point.distance_to(north_pole) + point.distance_to(south_pole)).to eq(20_015.08)
  end

  it "is equal when another point has the same lat and long" do
    original = Point.new(lat:10, long: 10)
    same_location = Point.new(lat:10, long: 10)
    wrong_lat = Point.new(lat:90, long: 10)
    wrong_long = Point.new(lat:10, long: 90)

    expect(original).to eq(same_location)
    expect(original).to_not eq(wrong_lat)
    expect(original).to_not eq(wrong_long)
  end
end
