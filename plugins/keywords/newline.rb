module Keywords
  module Newline
    VALUE = ';'

    module_function

    def process_stream(stream:, result:, **_)
      return unless stream.peek == VALUE
      result << Keyword::Newline.new(stream.next)
    end

  end
end




















