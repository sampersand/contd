class CharStream

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

  def next
    @chars.shift || fail 
  end

  def feed(*vals)
    @chars.unshift *vals
  end

  def empty?
    @chars.empty?
  end

  def peek
    @chars.first
  end

  def reset_to other_stream
    @chars = other_stream.to_a
    self
  end

  def to_a
    @chars.clone
  end

  def next_while(&block)
    raise "No block given!" unless block_given?
    res = []
    res << self.next while block.(peek, res, self) && !empty?
    res
  end
end