module Comment
  module SingleLine
    
    START = '#'
    module_function

    def process_stream(stream:, result:, **_)
      return unless stream.peek == START
      nil until stream.next == "\n"
      true
    end

  end
end
