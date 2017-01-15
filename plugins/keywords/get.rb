require_relative 'shared_functions'

module Keywords
  module Get
    VALUE = '!'

    module_function

    def process_stream(stream:, result:, **_)
      return unless stream.peek == VALUE
      result << Keyword::Get.new(stream.next)
    end

  end
end




















