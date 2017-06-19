require "rspec"
require_relative "../lib/customer_details"

RSpec.describe CustomerDetails do
  let(:lat) { "51.8856167" } 
  let(:long) { "51.8856167" } 
  let(:customer_name) { "Ian McArdle" }
  let(:file) { StringIO.new(<<~HEREDOC
                      {"latitude": "#{lat}", "user_id": 1, "name": "#{customer_name}", "longitude": "#{long}"}
                      {"latitude": "52.3191841", "user_id": 2, "name": "Jack Enright", "longitude": "-8.5072391"}
                      HEREDOC
                     )}

  it "can load customers from a file" do
    customers = CustomerDetails.from_file(file).customers

    expect(customers.size).to eq(2)
    expect(customers[0].name).to eq(customer_name)
    expect(customers[0].id).to eq(1)
    expect(customers[0].location).to eq(Point.new(lat: lat, long: long))
  end

  it "returns an error on missing keys" do
    file = StringIO.new('{"name": "Joe Bloggs"}')

    expect{CustomerDetails.from_file(file).customers}.to raise_error(KeyError)
  end

  it "returns an error on badly formatted json" do
    message = "Expecting newline separated json objects with: 'user_id', 'name', 'latitude' and 'longitude' fields"
    file = StringIO.new('{name: "Joe Bloggs"}')

    expect{CustomerDetails.from_file(file).customers}.to raise_error(message)
  end
end
