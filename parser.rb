class Parser
  require_relative 'container'
  require_relative 'keyword'
  require_relative 'builtins'

  def parse(body)
    result = Container.new
    body_iter = body.each_char
    body_iter = parse_includes_and_comments(body_iter, result)
    parse_iterable(body_iter)
    result
  end

  private

  def parse_includes_and_comments(body_iter, result)
    parsed_body = []
    loop do 
      char = body_iter.next
      if is_comment?(char)
        line = ''
        line += body_iter.next until is_end_comment?(line)
        parse_include(line, result)
      else 
        parsed_body << char
      end
    end
    parsed_body
  end

  def is_comment?(char)
    char == '#'
  end

  def is_end_comment?(line)
    line[-1] == "\n"
  end

  def parse_include(line, result)
    return unless line.start_with?('!INCLUDE')

    parsed_to_include = line.split('!INCLUDE', 2)[1].strip
    to_include = get_include(parsed_to_include)

    raise "Unknown include `#{parsed_to_include}`" unless to_include

    result[ to_include.name ] = to_include
  end

  def get_include(parsed)
    Builtins.const_get(parsed)
  end

  def parse_iterable(body)
  end

end


















