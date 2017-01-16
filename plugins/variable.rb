module Variable

  module_function

  VARIABLE_START_REGEX = /[a-zA-Z_]/
  VARIABLE_BODY_REGEX  = /[a-zA-Z0-9_]/

  def process_stream(parser)
    return unless VARIABLE_START_REGEX =~ parser.peek
    res = parser.next + parser.next_while(&VARIABLE_BODY_REGEX.method(:=~))
    res.empty? ? nil : result << res.to_sym
  end
end


















