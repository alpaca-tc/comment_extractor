module CommentExtractor
  class CodeObject
    attr_accessor :metadata, :value

    def initialize(value: nil, **others)
      @value = value
      @metadata = others
    end
  end
end

require 'comment_extractor/code_object/comment'
