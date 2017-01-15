require_relative 'shared_functions'

module Keywords
  module Call
    VALUE = '@'

    module_function

    def process_stream(stream:, result:, **_)
      return unless stream.peek == VALUE
      result << Keyword::Call.new(stream.next)
    end

  end
end




















