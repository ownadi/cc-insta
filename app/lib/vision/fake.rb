module Vision
  class Fake
    def initialize(attribute); end

    def faces
      [[{ 'x' => 300, 'y' => 177 }, { 'x' => 451, 'y' => 177 }, { 'x' => 451, 'y' => 329 }, { 'x' => 300, 'y' => 329 }]]
    end

    def labels
      %w(foo bar)
    end

    def safe_search
      true
    end
  end
end
