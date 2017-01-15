module Variable

  module_function

  VARIABLE_REGEX = /^[\w]+$/ #this leads to problems with `0ten_10`

  def process_stream(stream:, result:,  **_)
    ret = ''
    ret += stream.next while VARIABLE_REGEX =~ ret + stream.peek
    ret.empty? ? nil : result << ret
  end
end




















