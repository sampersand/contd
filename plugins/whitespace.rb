module Whitespace

  module_function

  WHITESPACE_REGEX = /\s/

  def process_stream(stream:, **_)
    return unless WHITESPACE_REGEX =~ stream.peek
    stream.next while WHITESPACE_REGEX =~ stream.peek
    true
  end
end




















