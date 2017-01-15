require_relative 'keywords/get'
require_relative 'keywords/call'
require_relative 'keywords/newline'

module Keywords

  module_function

  def process_stream(**kwargs)
    Keywords::Get.process_stream(**kwargs) ||
    Keywords::Call.process_stream(**kwargs) ||
    Keywords::Newline.process_stream(**kwargs)

  end

end




















