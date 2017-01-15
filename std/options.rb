module Std

  private 

  class OptionsClass
    def whitespace?(token)
      /\s/ =~ token
    end
  end

  public

  Options = OptionsClass.new

end