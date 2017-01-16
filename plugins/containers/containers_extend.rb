module Containers

  module ExtendedMethods
    def handle_next(parser)
        return unless parser.peek == self::START

        parser.next # pop START

        body = ''
        body += parser.next until parser.peek == self::STOP

        parser.next # pop STOP

        parser.result << parser.fork(body).run

        true
      rescue parser.class::EOFError => e
        raise parser.class::EOFError,
              "Reached end of stream whilst looking for end of container (`#{self::STOP.inspect}`)"
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end

