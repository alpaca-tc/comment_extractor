class StripComment::CodeObject
  attr_accessor :file, :metadata, :value

  def initialize
    @file = nil
    @value = nil
    @metadata = {}
  end

  autoload :Comment, 'strip_comment/code_object/comment'
end
