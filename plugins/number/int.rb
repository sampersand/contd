module Number
  module Int
    
    module_function

    def next_token(stream:, **_)
      res = stream.next_until{ |char| /[^\d]/ !~ stream.peek }.join
      res.empty? ? nil : res
    end

    def handle_token(token:, result:, **_)
      return unless /^\d+$/ =~ token
      result << token.to_i
    end
  end
end
