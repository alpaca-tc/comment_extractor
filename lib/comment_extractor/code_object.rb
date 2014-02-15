module CommentExtractor
  class CodeObject
    attr_accessor :file, :metadata, :value

    def initialize
      @file = nil
      @value = nil
      @metadata = {}
    end

    autoload :Comment, 'comment_extractor/code_object/comment'
  end
end
