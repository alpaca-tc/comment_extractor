require 'comment_extractor/code_object'

module CommentExtractor
  class CodeObject
    class Comment < CommentExtractor::CodeObject
      attr_accessor :line

      module Type
        ONE_LINER_COMMENT = :one_liner_comment
        BLOCK_COMMENT = :block_comment
      end

      def initialize(line: line, **values)
        super(**values)
        @line = line
      end
    end
  end
end
