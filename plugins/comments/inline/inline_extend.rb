require_relative '../comments_extend'

module Comments
  module Inline

    STOP = "\n"

    module_function

    def extended(other)
      raise "Inline `#{other}` has :STOP defined!" if other.const_defined? :STOP
      other.const_set(:STOP, STOP)
      other.extend(Comments)
    end

  end
end
