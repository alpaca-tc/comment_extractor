module CommentExtractor
  class CodeObject
    attr_accessor :file, :metadata, :value

    def initialize
      @file = nil
      @value = nil
      @metadata = {}
    end

    require 'comment_extractor/code_object/comment'
  end
end
