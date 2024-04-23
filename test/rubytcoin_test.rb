require "minitest/autorun"
require "rubytcoin"

class RubytcoinTest < Minitest::Test
  def test_on_curve
    prime = 223
    a = FieldElement.new(0, prime)
    b = FieldElement.new(7, prime)

    valid_points = [[192, 105], [17, 56], [1, 193]]
    invalid_points = [[200, 119], [42, 99]]

    valid_points.each do |point|
      x = FieldElement.new(point[0], prime)
      y = FieldElement.new(point[1], prime)

      assert_silent do
        Point.new(x, y, a, b)
      end
    end

    invalid_points.each do |point|
      x = FieldElement.new(point[0], prime)
      y = FieldElement.new(point[1], prime)

      assert_raises do
        Point.new(x, y, a, b)
      end
    end
  end
end
