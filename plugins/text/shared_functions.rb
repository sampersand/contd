module TextSharedFunctions

  module_function

  def process_stream(plugin:, stream:, result:, **_)
    fail "this only works for quotes and esapes of len 1" unless plugin::QUOTE.length == 1 &&
                                                                 plugin::ESCAPE.length == 1
    return unless stream.peek == plugin::QUOTE
    start_quote = stream.next
    quote = start_quote
    loop do
      quote += stream.next
      case quote[-1]
      when plugin::ESCAPE
        quote += stream.next
      when start_quote
        break
      when nil
        raise EOFError.new
      end
    end
    result << quote
    true
  rescue stream.class::EOFError => e
    puts 'a'
    raise stream.class::EOFError,
          "Reached end of stream whilst looking for end of text (`#{plugin::QUOTE}`)"
  end


end