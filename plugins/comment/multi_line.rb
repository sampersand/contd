module Comment
  module MultiLine
    
    START = '/*'
    STOP  = '*/'
    module_function

    def process_stream(stream:, result:, **_)
      return unless stream.peek(2) == START
      nil until stream.next == STOP
      true
    rescue stream.class::EOFError => e
      raise stream.class::EOFError,
            "Reached end of stream whilst looking for end of comment '#{STOP}'"
    end

  end
end
