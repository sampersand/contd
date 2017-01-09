# class ParserAPI


#   def start_comment(char, token, results) end
#   def continue_comment(char, token, results) end
#   def end_comment(char, token, results) end

#   def start_token(char, token, results) end
#   def continue_token(char, token, results) end
#   def end_token(char, token, results) end

# end

class DefaultParserAPI
  def initialize(parser)
    @parser = parser
  end

  COMMENT_START = %r(#.*$)
  COMMENT_END = /\n/
  WHITESPACE = /\s/
  NONTOKEN_CHARS = /\W/
  KEYWORDS = {'!': Keyword::Get, '@': Keyword::Call}

  CONTAINER_START = /[{(\[]/
  CONTAINER_END   = /[})\]]/


  def start_comment(char, token, *_)
    return unless COMMENT_START.match char
    token.concat char
  end

  def continue_comment(char, token, *_)
    COMMENT_START =~ token && COMMENT_END !~ char
    token.concat char
  end

  def end_comment(char, token, *_)
    return unless COMMENT_START =~ token && COMMENT_END =~ char
    token.sub!(COMMENT_START, '')
  end



  def start_token(char, token, *_)
    return unless token.empty?
    return if NONTOKEN_CHARS =~ char
    continue_token(char, token.clear)
  end

  def continue_token(char, token, *_)
    return if NONTOKEN_CHARS =~ char
    token.concat char
  end

  def end_token(char, token, results, *_)
    results << parse_token(token) unless token.empty? 
    results << parse_token(char)  unless WHITESPACE =~ char || CONTAINER_END =~ char
    token.clear
  end

  def parse_token(token)
    token = token.to_sym
    return KEYWORDS[token].new if KEYWORDS.include?(token)
    token
  end

  def start_container(char, token, results, iter)
    return unless CONTAINER_START =~ char
    to_add = results.class.new
    @parser.parse_body(iter, to_add)
    results << to_add
  end

  def end_container(char, *args)
    return unless CONTAINER_END =~ char
    end_token(char, *args)
  end

end















