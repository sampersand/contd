module Variable

  module_function

  VARIABLE_REGEX = /\w+/ #this leads to problems with `0ten_10`

  def process_stream(stream:, result:,  **_)
    ret = ''
    # ret += stream.next while VARIABLE_REGEX =~ ret + stream.peek && !stream.empty?
    while VARIABLE_REGEX =~ ret + stream.peek && !stream.empty?
      p ret + stream.peek
      ret += stream.next

    end
    ret.empty? ? nil : result << ret
  end
end


















