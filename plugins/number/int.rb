module Number
  module Int
    
    module_function

    def process_stream(stream:, result:, **_)
      return unless /\d/ =~ stream.peek
      result << stream.next_while{ |char| /[\d]/ =~ stream.peek }.join.to_i
    end

  end
end
