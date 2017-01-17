module Whitespace

  WHITESPACE_REGEX = /\s/

  module_function

  def handle_next(parser:, **_)
    parser.next_while(&WHITESPACE_REGEX.method(:=~)).empty? ? nil : true
  end

end




















