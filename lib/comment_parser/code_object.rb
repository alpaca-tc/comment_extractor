class CommentParser::CodeObject
  attr_accessor :file, :metadata, :value

  def initialize
    @file = nil
    @value = nil
    @metadata = {}
  end

  autoload :Comment, 'comment_parser/code_object/comment'
end
