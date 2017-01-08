class ParserOptions < Hash
  def method_missing(meth)
    include?(meth) ? self[meth] : super
  end
end