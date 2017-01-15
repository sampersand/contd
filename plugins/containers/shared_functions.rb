module SharedFunctions
  module_function
  def process_stream(container:, stream:, result:, parser:, **_)
      return unless stream.peek == container::START

      stream.next # pop START

      body = ''
      body += stream.next until stream.peek == container::STOP

      stream.next # pop STOP

      result << parser.parse(body)

      true
    rescue stream.class::EOFError => e
      raise stream.class::EOFError,
            "Reached end of stream whilst looking for end of container (`#{STOP}`)"
  end
end