require_relative 'keywords/get'
require_relative 'keywords/call'
require_relative 'keywords/newline'

module Keywords

  module_function

  def handle_next(parser)
    Get.handle_next(parser) ||
    Call.handle_next(parser) ||
    Newline.handle_next(parser)

  end

end




















