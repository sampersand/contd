module Containers
  module Parens
    
    START = '('
    STOP  = ')'
    module_function

    def process_stream(stream:, result:, parser:, **_)
      return unless stream.peek == START

      stream.next # pop START

      body = ''
      body += stream.next until stream.peek == STOP

      stream.next # pop STOP

      result << parser.parse(body)

      true
    rescue stream.class::EOFError => e
      raise stream.class::EOFError,
            "Reached end of stream whilst looking for end of comment '#{STOP}'"
    end

  end
end
