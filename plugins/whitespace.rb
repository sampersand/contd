module Whitespace

  module_function

  WHITESPACE_REGEX = /\s/

  def process_stream(stream:, **_)
    stream.next_while(&WHITESPACE_REGEX.method(:=~)).empty? ? nil : true
  end
end




















