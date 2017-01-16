require_relative 'whole'

module Numbers
  module Real

    module_function


    REAL_START = /\d/
    REAL_BODY = /\d*\.\d+/

    def handle_next(parser)
      return unless REAL_REGEX =~ parser.peek
      exit
      stream_copy = stream.clone

      if Whole.handle_next(stream: stream, result: result, **_)
        left = result.pop # int pushes it into the input stream
      else
        stream.reset_to stream_copy
        return 
      end
      
      if stream.peek == '.'
        deci = stream.next
      else
        stream.reset_to stream_copy
        return
      end

      if Whole.handle_next(stream: stream, result: result, **_)
        right = result.pop # int pushes it into the input stream
      else
        stream.reset_to stream_copy
        return 
      end

      result << "#{left}#{deci}#{right}".to_f
    end

   end
end

