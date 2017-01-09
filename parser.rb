class Parser
  require_relative 'container'
  require_relative 'keyword'
  require_relative 'builtins'

  def parse(body)
    result = Container.new
    body_iter = body.each_char
    body_iter = parse_includes_and_comments(body_iter, result)
    parse_iterable(body_iter, result)
    result
  end

  private

  def parse_includes_and_comments(body_iter, result)
    parsed_body = []
    loop do 
      if is_comment?(char = body_iter.next)
        handle_comment(body_iter, result)
      else
        parsed_body << char
      end
    end
    parsed_body.each
  end

    def is_comment?(char)
      char == '#'
    end

    def handle_comment(body_iter, result)
      line = ''
      line += body_iter.next until is_end_comment?(line)
      parsed_include = parse_include(line)
      handle_include(parsed_include, result) if parsed_include
    end

      def is_end_comment?(line)
        line[-1] == "\n"
      end

      def parse_include(line)
        parsed = line.split(include_prefix, 2)[1]
        return unless parsed
        parsed.strip
      end

        def include_prefix
          '!INCLUDE'
        end

      def handle_include(parsed, result)
        to_include = get_include(parsed)
        raise "Unknown include `#{parsed}`" unless to_include
        result[ get_include_key(to_include) ] = to_include
      end

        def get_include(parsed)
          Builtins.const_get(parsed)
        end

        def get_include_key(to_include)
          to_include.name
        end


  def parse_iterable(body, result)
    loop do
      case (token = body.next)
      when 1
      else 
        p token
      end
    end
  end

end


















