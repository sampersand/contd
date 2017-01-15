module Number
  module Int
    
    module_function

    def next_token(stream:, **_)
      res = ''
      res += stream.shift until /[^\d]/ =~ stream.first
      res.empty? ? nil : res
    end

    def handle_token(token:, result:, **_)
      return unless /^\d+$/ =~ token
      result << token.to_i
    end
  end
end
