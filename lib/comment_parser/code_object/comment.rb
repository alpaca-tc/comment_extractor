class CommentParser::CodeObject::Comment < CommentParser::CodeObject
  attr_accessor :line

  def initialize
    super
    @line = nil
  end
end
