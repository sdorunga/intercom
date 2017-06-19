module ArrayRefinements
  refine Array do
    def flatten_nested
      self.reduce([]) do |acc, element|
        next acc << element if is_flat?(element)

        acc + element.flatten_nested
      end
    end

    private

    def is_flat?(element)
      !element.is_a?(Array)
    end
  end
end
