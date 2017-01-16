require_relative 'keywords/get'
require_relative 'keywords/call'
require_relative 'keywords/newline'

module Keywords

  module_function

  def handle_next(**kwargs)
    Get.handle_next(**kwargs) ||
    Call.handle_next(**kwargs) ||
    Newline.handle_next(**kwargs)

  end

end




















