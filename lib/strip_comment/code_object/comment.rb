class StripComment::CodeObject::Comment < StripComment::CodeObject
  cattr_accessor :line

  def initialize
    super
    self.line = nil
  end
end
