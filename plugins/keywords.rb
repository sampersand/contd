module Keywords
  KEYWORDS = {
    '!' => Keyword::Get,
    '@' => Keyword::Call,
    ';' => Keyword::Newline
  }

  module_function


  def process_stream(stream:, result:, **_)
    return unless KEYWORDS.include? stream.peek
    result << KEYWORDS[stream.peek].new(stream.next)
  end
end




















