module Std
  class Function
    def initialize(&func)
      @func = func
    end

    def inspect
      "#{self.class}"
    end

    def call(args:, results:)
      @func.call(args: args, results: results)
    end
  end
end

















