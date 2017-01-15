module Keywords
  module Call
    KEYWORD_REGEX = '@'

    module_function

    def process_stream(stream:, result:, **_)
      return unless stream.peek == KEYWORD_REGEX
      result << Keyword::Call.new(stream.next)
    end

  end
end




















