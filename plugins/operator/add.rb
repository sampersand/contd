module Operator
  module Add
    VALUE = '+'

    module_function

    def on_added(parser)
    end

    def process_stream(stream:, result:, parser:, **_)
      return unless stream.peek == VALUE
      left = result.pop
      var = stream.next
      right = parser.process_stream(stream: stream, result: result) # WARNING: WILL FAIL WITH `a!`
      p right
      exit
      result << stream.nextKeyword::Call.new(stream.next)
    end

  end
end




















