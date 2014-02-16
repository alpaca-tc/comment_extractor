module CommentExtractor
  class CodeObject
    class Comment < CommentExtractor::CodeObject
      attr_accessor :line

      module Type
        ONE_LINER_COMMENT = :one_liner_comment
        BLOCK_COMMENT = :block_comment
      end

      def initialize(line: line, **values)
        @line = line
        super(**values)
      end
    end
  end
end
