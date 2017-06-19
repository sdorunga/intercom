require "rspec"
require_relative "../lib/array_refinement"

RSpec.describe "Flattening nested arrays" do
  let(:empty_array) { [] }
  let(:flat_array) { [1,2,3] }
  let(:single_nesting_array) { [1,[2],3] }
  let(:double_nested_array) { [1,[2, [3]],4] }

  using ArrayRefinements
  it "returns an empty array if original is empty" do
    expect([].flatten_nested).to eq([])
  end

  it "returns original array if it is already flat" do
    expect(flat_array.flatten_nested).to eq(flat_array)
  end

  it "it can unnest variable levels of nesting" do
    expect([nil].flatten_nested).to eq([nil])
    expect(single_nesting_array.flatten_nested).to eq([1,2,3])
    expect(double_nested_array.flatten_nested).to eq([1,2,3,4])
  end
end
