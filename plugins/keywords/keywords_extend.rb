module Keywords
  module ExtendedMethods
    def handle_next(parser)
      return unless parser.peek(self::VALUE.length) == self::VALUE
      parser.result << self::KEYWORD.new(parser.next(self::VALUE.length))
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end