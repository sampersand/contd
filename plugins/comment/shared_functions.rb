module CommentSharedFunctions

  module_function

  def process_stream(comment:, stream:, result:, **_)
    return unless stream.peek(comment::START.length) == comment::START

    stream.next(comment::START.length) #to remove the START
    stream.next until stream.peek(comment::STOP.length) == comment::STOP
    stream.next(comment::STOP.length) #to remove the STOP

    true
  rescue stream.class::EOFError => e
    raise stream.class::EOFError,
          "Reached end of stream whilst looking for end of comment (`#{STOP}`)"
  end

end