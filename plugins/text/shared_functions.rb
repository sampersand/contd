module TextSharedFunctions

  module_function

  def process_stream(plugin:, stream:, result:, **_)
    fail "this only works for quotes and esapes of len 1" unless plugin::QUOTE.length == 1 &&
                                                                 plugin::ESCAPE.length == 1
    return unless stream.peek == plugin::QUOTE

    start_quote = stream.next
    end_quote = start_quote
    body = ''

    until body[-1] == end_quote
      body += stream.next
      body += stream.next if body[-1] == plugin::ESCAPE
    end
    result << start_quote + body
    true
  rescue stream.class::EOFError => e
    raise stream.class::EOFError,
          "Reached end of stream whilst looking for end of text (`#{plugin::QUOTE}`)"
  end


end