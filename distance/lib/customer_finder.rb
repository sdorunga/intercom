require_relative "./point"
require_relative "./customer_details"

class CustomerFinder
  def initialize(office_lat:, office_long:, user_file_path:, distance:)
    @office_lat = office_lat
    @office_long = office_long
    @user_file_path = user_file_path
    @distance = distance
  end

  def qualifying_customers
    office = Point.new(lat: @office_lat, long: @office_long)
    users_file = File.open(@user_file_path, "r")

    customers = CustomerDetails.from_file(users_file).customers
    customers.select {|customer| customer.within(distance: @distance, to: office)}.
      sort_by(&:id).
      map(&:to_s)
  end
end

if __FILE__ == $0
  puts CustomerFinder.new(office_lat: ARGV[0], 
                     office_long: ARGV[1], 
                     user_file_path: ARGV[2], 
                     distance: ARGV[3]).qualifying_customers
end
