require "json"
require_relative "customer"

class CustomerDetails
  def self.from_file(file)
    CustomerDetails.new(file)
  end

  def initialize(file)
    @file = file
  end

  def customers
    @customers ||= begin
      customers = @file.each_line.map do |line|
        build_customer(parse_line(line))
      end
      @file.close
      customers
    end
  end

  private

  def build_customer(json)
    location = Point.new(lat: json.fetch(:latitude), long: json.fetch(:longitude))

    Customer.new(id: json.fetch(:user_id),
                 name: json.fetch(:name),
                 location: location)
  end

  def parse_line(line)
    begin
      JSON.parse(line, symbolize_names: true)
    rescue JSON::ParserError
      raise "Expecting newline separated json objects with: 'user_id', 'name', 'latitude' and 'longitude' fields"
    end
  end
end
