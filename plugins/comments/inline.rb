require_relative 'inline/c_style'
require_relative 'inline/pound'
module Comments
  module Inline

    module_function

    def handle_next(parser)
      CStyle.handle_next(parser) ||
      Pound.handle_next(parser)
    end

  end
end
