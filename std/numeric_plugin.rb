require_relative 'options'

module Std

  class NumericPlugin

    def handle_token(token, result, iter)
      case token
      when /\d+/
        result << token.to_i
      when /\d+\.\d+/
        result << token.to_f
      end
    end
  end

end




















