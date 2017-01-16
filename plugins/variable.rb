module Variable

  VARIABLE_START_REGEX = /[a-zA-Z_]/
  VARIABLE_BODY_REGEX  = /[a-zA-Z0-9_]/

  module_function

  def handle_next(parser)
    return unless VARIABLE_START_REGEX =~ parser.peek
    res = parser.next + parser.next_while(&VARIABLE_BODY_REGEX.method(:=~))
    res.empty? ? nil : parser.result << res.to_sym
  end
end


















