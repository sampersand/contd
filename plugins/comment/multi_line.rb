module Comment
  module MultiLine
    
    START = '/*'
    STOP  = '*/'
    module_function

    def process_stream(stream:, result:, **_)
      return unless stream.peek(2) == START
      stream.next until stream.peek(2) == STOP
      stream.next(2) #to remove the STOP

      true
    rescue stream.class::EOFError => e
      raise stream.class::EOFError,
            "Reached end of stream whilst looking for end of comment (`#{STOP}`)"
    end

  end
end
