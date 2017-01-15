module Text

  module_function

  QUOTE_REGEX = /['"]/
  ESCAPE_CHAR = /\\/
  STRING_REGEX = /^(#{QUOTE_REGEX}).+(?<!#{ESCAPE_CHAR})\1$/

  def next_token(stream:, **_)
    return unless QUOTE_REGEX =~ stream.peek
    start_quote = stream.next
    res = start_quote
    loop do
      case res += stream.next
      when 
      end
    end

  end

  def handle_token(token:, result:, **_)
    return unless STRING_REGEX =~ token
    result << token.to_i
  end
end






















