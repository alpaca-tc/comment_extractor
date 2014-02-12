class CommentParser::CodeObject::Comment < CommentParser::CodeObject
  attr_accessor :line

  module Type
    ONE_LINER_COMMENT = :one_liner_comment
    BLOCK_COMMENT = :block_comment
  end

  def initialize
    super
    @line = nil
  end
end
