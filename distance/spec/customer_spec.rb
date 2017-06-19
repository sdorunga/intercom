require "rspec"
require_relative "../lib/customer"

RSpec.describe Customer do
  let(:customer_location) { Point.new(lat: 0.0, long: 0.0) }
  let(:customer) { Customer.new(id: 1, name: "Joe", location: customer_location) }
  let(:office_within_area) { Point.new(lat: 0.0, long: 0.89) }
  let(:office_outside_area) { Point.new(lat: 0.0, long: 0.90) }

  it "knows whether it's within a certain distance to a place" do
    expect(customer.within(distance: 100, to: office_within_area)).to be true
    expect(customer.within(distance: 100, to: office_outside_area)).to be false
  end
end
