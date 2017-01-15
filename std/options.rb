module Std
  class Options
    def each_token(input, &block)
      input.each_char(&block)
    end
  end
end