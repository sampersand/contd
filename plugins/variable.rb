module Variable

  module_function

  VARIABLE_START_REGEX = /[a-zA-Z_]/
  VARIABLE_BODY_REGEX  = /[a-zA-Z0-9_]/

  def process_stream(stream:, result:,  **_)
    return unless VARIABLE_START_REGEX =~ stream.peek
    res = stream.next + stream.next_while(&VARIABLE_BODY_REGEX.method(:=~))
    res.empty? ? nil : result << res.to_sym
  end
end


















