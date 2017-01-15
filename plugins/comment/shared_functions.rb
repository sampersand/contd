module CommentSharedFunctions

  module_function

  def process_stream(plugin:, stream:, result:, **_)
    return unless stream.peek(plugin::START.length) == plugin::START

    stream.next(plugin::START.length) #to remove the START
    stream.next until stream.peek(plugin::STOP.length) == plugin::STOP
    stream.next(plugin::STOP.length) #to remove the STOP

    true
  rescue stream.class::EOFError => e
    raise stream.class::EOFError,
          "Reached end of stream whilst looking for end of plugin (`#{STOP}`)"
  end

end