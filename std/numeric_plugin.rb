module Std

  class NumericPlugin
    def next_token(iter)
      return unless /\d/ =~ iter.peek
      res = ''
      res += iter.next until /[^.\d]/ =~ iter.peek
      res
    end

    def handle_token(token, result, iter)
      case token
      when /\d+\.\d+/
        result << token.to_f
      when /\d+/
        result << token.to_i
      end
    end
  end

end




















