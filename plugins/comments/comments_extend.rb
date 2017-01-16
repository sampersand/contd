module Comments
  module ExtendedMethods
    def handle_next(parser)
      return unless parser.peek(self::START.length) == self::START

      parser.next(self::START.length) #to remove the START
      parser.next until parser.peek(self::STOP.length) == self::STOP
      parser.next(self::STOP.length) #to remove the STOP

      true
    rescue parser.class::EOFError => e
      raise parser.class::EOFError,
            "Reached end of stream whilst looking for end of comment (`#{self::STOP.inspect}`)"
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end