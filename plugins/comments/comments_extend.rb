module Comments
  module ExtendedMethods
    def process_stream(stream:, result:, **_)
      return unless stream.peek(self::START.length) == self::START

      stream.next(self::START.length) #to remove the START
      stream.next until stream.peek(self::STOP.length) == self::STOP
      stream.next(self::STOP.length) #to remove the STOP

      true
    rescue stream.class::EOFError => e
      raise stream.class::EOFError,
            "Reached end of stream whilst looking for end of self (`#{self::STOP.inspect}`)"
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end