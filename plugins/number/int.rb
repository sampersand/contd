module Number
  module Int
    
    module_function

    def process_stream(stream:, result:, **_)
      res = ''
      res << stream.next while /\d/ =~ stream.peek 
      res.empty? ? nil : result << res.to_i
    end

  end
end
