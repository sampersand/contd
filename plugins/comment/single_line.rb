module Comment
  module SingleLine
    
    START = '#'
    STOP = "\n"

    module_function

    def process_stream(stream:, result:, **_)
      return unless stream.peek == START
      stream.next until stream.peek == STOP
      stream.next #to remove the STOP
      true
    rescue stream.class::EOFError => e
      raise stream.class::EOFError,
            "Reached end of stream whilst looking for end of comment (`#{STOP}`)"
    end

  end
end
