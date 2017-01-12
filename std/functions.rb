module Std
  class Function
    def initialize(&func)
      @func = func
    end

    def inspect
      "#{self.class}"
    end
    def to_s
      self.class.name.split('::')[-1]
    end

    def call(args:, results:)
      @func.call(args: args, results: results)
    end
  end
end


















