module Whitespace

  module_function

  WHITESPACE_REGEX = /\s/

  def process_stream(stream:, **_)
    !stream.next_while{ |token| WHITESPACE_REGEX =~ token}.empty?
  end
end




















