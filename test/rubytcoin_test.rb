require "minitest/autorun"
require "rubytcoin"

class RubytcoinTest < Minitest::Test
  def setup
    @prime = 223
    @a = FieldElement.new(0, @prime)
    @b = FieldElement.new(7, @prime)
  end

  def test_on_curve
    valid_points = [[192, 105], [17, 56], [1, 193]]
    invalid_points = [[200, 119], [42, 99]]

    valid_points.each do |point|
      x = FieldElement.new(point[0], @prime)
      y = FieldElement.new(point[1], @prime)

      assert_silent do
        Point.new(x, y, @a, @b)
      end
    end

    invalid_points.each do |point|
      x = FieldElement.new(point[0], @prime)
      y = FieldElement.new(point[1], @prime)

      assert_raises do
        Point.new(x, y, @a, @b)
      end
    end
  end

  def test_addition
    # Addition no.1
    x1 = FieldElement.new(170, @prime)
    y1 = FieldElement.new(142, @prime)
    x2 = FieldElement.new(60, @prime)
    y2 = FieldElement.new(139, @prime)

    p1 = Point.new(x1, y1, @a, @b)
    p2 = Point.new(x2, y2, @a, @b)

    sum = p1 + p2

    assert_equal Point.new(FieldElement.new(220, @prime), FieldElement.new(181, @prime), @a, @b), sum

    # Addition no.2
    x1 = FieldElement.new(47, @prime)
    y1 = FieldElement.new(71, @prime)
    x2 = FieldElement.new(17, @prime)
    y2 = FieldElement.new(56, @prime)

    p1 = Point.new(x1, y1, @a, @b)
    p2 = Point.new(x2, y2, @a, @b)

    sum = p1 + p2

    assert_equal Point.new(FieldElement.new(215, @prime), FieldElement.new(68, @prime), @a, @b), sum

    # Addition no.3
    x1 = FieldElement.new(143, @prime)
    y1 = FieldElement.new(98, @prime)
    x2 = FieldElement.new(76, @prime)
    y2 = FieldElement.new(66, @prime)

    p1 = Point.new(x1, y1, @a, @b)
    p2 = Point.new(x2, y2, @a, @b)

    sum = p1 + p2

    assert_equal Point.new(FieldElement.new(47, @prime), FieldElement.new(71, @prime), @a, @b), sum
  end
end
