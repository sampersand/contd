require_relative 'inline/c_style'
require_relative 'inline/pound'
module Comments
  module Inline

    module_function

    def process_stream(**kwargs)
      CStyle.process_stream(**kwargs) ||
      Pound.process_stream(**kwargs)
    end

  end
end
