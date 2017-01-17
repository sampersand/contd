module Variable

  VARIABLE_START_REGEX = /[a-z_]/i
  VARIABLE_BODY_REGEX  = /[a-z0-9_]/i

  module_function

  def handle_next(parser:, result:)
    return unless VARIABLE_START_REGEX =~ parser.peek
    res = parser.next + parser.next_while(&VARIABLE_BODY_REGEX.method(:=~))
    res.empty? ? nil : (result << res) && true
  end
end


















