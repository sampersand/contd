module Containers

  module ExtendedMethods
    def process_stream(stream:, result:, parser:, **_)
        return unless stream.peek == self::START

        stream.next # pop START

        body = ''
        body += stream.next until stream.peek == self::STOP

        stream.next # pop STOP

        result << parser.parse(body)

        true
      rescue stream.class::EOFError => e
        raise stream.class::EOFError,
              "Reached end of stream whilst looking for end of container (`#{self::STOP.inspect}`)"
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end
