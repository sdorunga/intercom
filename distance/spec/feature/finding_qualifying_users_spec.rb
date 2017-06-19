require "rspec"
require_relative "../../lib/customer_finder"

RSpec.describe "Finding qualifying users by distance to office" do
  it "should only include users within the correct distance to a given location" do
    qualifying_customers = CustomerFinder.new(distance: 100,
                       office_lat: "53.3393", 
                       office_long: "-6.2576841",
                       user_file_path: __dir__ + "/users.txt").qualifying_customers
    expect(qualifying_customers).to eq([
       "4 -- Ian Kehoe",
       "5 -- Nora Dempsey",
       "6 -- Theresa Enright",
       "8 -- Eoin Ahearn",
       "11 -- Richard Finnegan",
       "12 -- Christina McArdle",
       "13 -- Olive Ahearn",
       "15 -- Michael Ahearn",
       "17 -- Patricia Cahill",
       "23 -- Eoin Gallagher",
       "24 -- Rose Enright",
       "26 -- Stephen McArdle",
       "29 -- Oliver Ahearn",
       "30 -- Nick Enright",
       "31 -- Alan Behan",
       "39 -- Lisa Ahearn"])
  end
end
