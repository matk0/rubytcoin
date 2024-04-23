class FieldElement
  attr_reader :number, :prime

  def initialize number, prime
    raise ArgumentError, "Number #{number} not in field range 0 to #{prime - 1}" if number >= prime || number.negative?

    @number = number
    @prime = prime
  end

  def to_s
    "FieldElement_#{prime}(#{number})"
  end

  def == other
    return False if other.nil?

    @number == other.number and @prime == other.prime
  end

  def != other
    return False if other.nil?

    @number != other.number or @prime != other.prime
  end

  def + other
    raise "Cannot add two numbers in different fields." if @prime != other.prime

    FieldElement.new((@number + other.number) % @prime, @prime)
  end

  def - other
    raise "Cannot subtract two numbers in different fields." if @prime != other.prime

    FieldElement.new((@number - other.number) % @prime, @prime)
  end

  def * other
    raise "Cannot multiply two numbers in different fields." if @prime != other.prime

    FieldElement.new((@number * other.number) % @prime, @prime)
  end

  def ** other
    n = other % (@prime - 1)
    FieldElement.new(@number.pow(n, @prime), @prime)
  end

  def / other
    raise "Cannot divide two numbers in different fields." if @prime != other.prime

    other_inverse = other**(@prime - 2)
    FieldElement.new((@number * other_inverse.number) % @prime, @prime)
  end
end
