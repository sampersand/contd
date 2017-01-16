module Operators
  module Add
    VALUE = '+'

    module_function

    def on_added(parser)
    end

    def process_stream(stream:, result:, parser:, **_)
      return unless stream.peek == VALUE
      args = Container.new
      args << result.pop
      name = stream.next
      i = 0
      loop do 
      p parser.process_stream(stream: stream, result: args) # WARNING: WILL FAIL WITH `a!`
      p stream
      p args
      exit
      result << stream.nextKeyword::Call.new(stream.next)
    end

  end
end




















