module Containers
  module Parens
    
    START = '('
    STOP  = ')'
    module_function

    def process_stream(stream:, result:, parser:, **_)
      return unless stream.peek == START
      
      res = Container.new

      res << parser.process_stream(stream: stream, result: res)
      p res
      exit
      stream.next until stream.peek == STOP
      stream.next(2) #to remove the STOP

      true
    rescue stream.class::EOFError => e
      raise stream.class::EOFError,
            "Reached end of stream whilst looking for end of comment '#{STOP}'"
    end

  end
end
