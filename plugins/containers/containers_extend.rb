module Containers

  module ExtendedMethods
    def handle_next(parser)
        return unless parser.peek == self::START

        parser.next # pop START

        body = ''
        paren_amnt = 1
        loop do
          paren_amnt += case parser.peek
                        when self::STOP then -1
                        when self::START then 1
                        else 0
                        end
          break if paren_amnt == 0
          body += parser.next
        end

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

