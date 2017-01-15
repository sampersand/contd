module Comment
  module SingleLine
    
    START = '#'
    STOP = "\n"

    module_function

    def process_stream(stream:, result:, **_)
      return unless stream.peek == START
      nil until stream.next == STOP
      true
    end

  end
end
