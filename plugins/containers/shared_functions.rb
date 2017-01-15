module ContainersSharedFunctions

  module_function

  def process_stream(plugin:, stream:, result:, parser:, **_)
      return unless stream.peek == plugin::START

      stream.next # pop START

      body = ''
      body += stream.next until stream.peek == plugin::STOP

      stream.next # pop STOP

      result << parser.parse(body)

      true
    rescue stream.class::EOFError => e
      raise stream.class::EOFError,
            "Reached end of stream whilst looking for end of container (`#{STOP}`)"
  end

end