class StripComment::CodeObject::Comment < StripComment::CodeObject
  attr_accessor :line

  def initialize
    super
    @line = nil
  end
end
