class CharStream

  def initialize(input)
    @stream = input.chars
  end

  def next
    @stream.shift || fail 
  end

  def feed(*vals)
    @stream.unshift *vals
  end

  def empty?
    @stream.empty?
  end

  def peek
    @stream.first
  end

  def next_until(&block)
    raise "No block given!" unless block_given?
    res = []
    res << self.next while block.(peek, res, self) && !empty?
    res
  end
end