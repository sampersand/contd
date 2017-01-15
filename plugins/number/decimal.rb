require_relative 'int'

module Number
  module Decimal

    module_function

    def next_token(stream:, **_)
      left = Int.next_token(stream: stream, **_)
      return unless left
      deci = stream.next
      unless deci == '.'
        stream.feed(*left, deci)
        return
      end
      right = Int.next_token(stream: stream, **_)
      "#{left}#{deci}#{right}"
   end

    def handle_token(token:, result:, **_)
      return unless /^\d+\.\d+$/ =~ token
      result << token.to_f

      # case token
      # when /\d+\.\d+/
      #   result << token.to_f
      # when /\d+/
      #   result << token.to_i
      # end
    end
  end

end

