require_relative 'comments/inline'
require_relative 'comments/block'

module Comments

  module_function

  def process_stream(**kwargs)
    Comments::Inline.process_stream(**kwargs) ||
    Comments::Block.process_stream(**kwargs)
  end

end