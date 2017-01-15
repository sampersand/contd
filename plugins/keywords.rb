require_relative 'keywords/get'
require_relative 'keywords/call'
require_relative 'keywords/newline'

module Keywords

  module_function

  def process_stream(**kwargs)
    Get.process_stream(**kwargs) ||
    Call.process_stream(**kwargs) ||
    Newline.process_stream(**kwargs)

  end

end




















