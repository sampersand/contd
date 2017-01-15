module KeywordsSharedFunctions

  module_function

  def process_stream(keyword:, stream:, result:, **_)
    return unless stream.peek(keyword::VALUE.length) == keyword::VALUE
    result << keyword::KEYWORD.new(stream.next(keyword::VALUE.length))
  end

end