module Keywords
  module Get
    KEYWORD_REGEX = '!'

    module_function

    def process_stream(stream:, result:, **_)
      return unless stream.peek == KEYWORD_REGEX
      result << Keyword::Get.new(stream.next)
    end

  end
end




















