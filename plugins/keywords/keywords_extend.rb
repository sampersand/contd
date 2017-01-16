module Keywords
  module ExtendedMethods
    def process_stream(stream:, result:, **_)
      return unless stream.peek(self::VALUE.length) == self::VALUE
      result << self::KEYWORD.new(stream.next(self::VALUE.length))
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end