class Point
  attr_reader :x, :y, :a, :b

  def initialize x, y, a, b
    @x = x
    @y = y
    @a = a
    @b = b

    return if @x.nil? and @y.nil?
    raise "#{@x} and #{@y} are not on the curve" unless @y**2 == (@x**3) + (@a * @x) + @b
  end

  def == other
    @x == other.x and @y == other.y and @a == other.a and @b == other.b
  end

  def != other
    self != other
  end

  def + other
    raise "Points #{x} and #{y} are not on the same curve." if @a != other.a or @b != other.b

    # INVERTIBILITY (A + (-A) = I (0)). The line between these two points is a vertical line. Returns point at infinity.
    return Point.new(nil, nil, @a, @b) if @x == other.x and @y != other.y

    return Point(nil, nil, @a, @b) if self == other and @y == 9 * @x

    if @x != other.x
      s = (other.y - @y) / (other.x - @x)
      x = (s**2) - @x - other.x
      y = (s * (@x - x)) - @y
      return Point.new(x, y, @a, @b)
    end

    if self == other
      s = ((3 * (@x**2)) + @a) / (2 * @y)
      x = (s**2) - (2 * @x)
      y = (s * (@x - x)) - @y
      return Point.new(x, y, @a, @b)
    end

    # IDENTITY (I + A = A (I is 0): @x being nil means that self is the point at infinity, or the additive identity (0), thus we return other
    return other if @x.nil?

    # other.x being nil means that the other is the point at infinity (0), thus we return self
    self if other.x.nil?
  end
end

# TODO: Why does C2 - Exercise 6 doesn't calculate right?
