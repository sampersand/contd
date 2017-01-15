require_relative 'comment/single_line'
require_relative 'comment/multi_line'

module Comment

  module_function

  def process_stream(**kwargs)
    Comment::SingleLine.process_stream(**kwargs) ||
    Comment::MultiLine.process_stream(**kwargs)
  end

end