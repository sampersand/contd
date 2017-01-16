class CharStream
  EOFError = Class.new SyntaxError
  attr_accessor :chars

  def self.from_str(input)
    new input.chars
  end

  def initialize(chars)
    @chars = chars
  end

  def clone
    self.class.new to_a
  end

  def next(amnt=1)
    @chars.empty? and fail(EOFError, "Reached end of stream!")
    @chars.shift(amnt).join
  end

  def feed(*vals)
    @chars.unshift *vals
  end

  def empty?
    @chars.empty?
  end

  def peek(amnt=1)
    @chars.first(amnt).join
  end

  def reset_to other_stream
    @chars = other_stream.to_a
    self
  end

  def to_a
    @chars.clone
  end

  def next_while(&block)
    res = []
    res << self.next while block.call(self.peek)
    res.join
  end

end




























