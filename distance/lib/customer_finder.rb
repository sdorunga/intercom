require "optparse"
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
  Options = Struct.new(:lat, :long, :path, :distance) do |options|
    def all_args_provided?
      !!(lat && long && path && distance)
    end
  end
  options = Options.new

  opt_parser = OptionParser.new do |opts|

    opts.banner = "Usage: ruby ./lib/customer_finder.rb --lat <office_lat> --lon <office_long> --path <user_file_path> --distance <distance_in_km>"

    opts.on("--lat LATITUDE", "Latitude of location to invite customers to") do |lat|
      options.lat = lat
    end

    opts.on("--lon LONGITUDE", "Longitude of location to invite customers to") do |lon|
      options.long = lon
    end

    opts.on("-p FILE_PATH", "--path FILE_PATH", "Path to file containing customer details") do |path|
      options.path = path
    end

    opts.on("-d DISTANCE", "--distance DISTANCE", "Farthest distance where a customer is invitable") do |distance|
      options.distance = distance
    end

    opts.on("-h", "--help", "Prints this help") do
      puts opts
      exit
    end
  end

  opt_parser.parse!(ARGV)
  if !options.all_args_provided?
    puts opt_parser
    exit
  end

  puts CustomerFinder.new(office_lat: options.lat, 
                          office_long: options.long, 
                          user_file_path: options.path, 
                          distance: options.distance).qualifying_customers
end
