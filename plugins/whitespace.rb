module Whitespace

  module_function

  WHITESPACE_REGEX = /\s/

  def process_next(parser)
    parser.next_while(&WHITESPACE_REGEX.method(:=~)).empty? ? nil : true
  end
end




















