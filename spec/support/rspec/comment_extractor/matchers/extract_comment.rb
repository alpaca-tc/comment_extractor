module RSpec::CommentExtractor::Matchers
  module ExtractComment
    class ExtractCommentMatcher < RSpec::Matchers::BuiltIn::BaseMatcher
      def initialize(scope, comment_list = {})
        @scope = scope
        @comment_list = comment_list
        @failure_case = []
      end

      # @api private
      def matches?(list_or_block)
        comments = list_or_block.is_a?(Proc) ? list_or_block.call : list_or_block
        @target_comment_list = @comment_list.dup

        comments.each do |comment_object|
          comment_expected = @target_comment_list.delete(comment_object.line)
          unless comment_expected == comment_object.value
            case_array = [comment_object.line, comment_expected, comment_object]
            @failure_case << case_array
          end
        end

        # all comemnts are extracted
        @failure_case.empty? && @target_comment_list.empty?
      end

      def failure_message_for_should
        messages = []
        @failure_case.each do |(line, expected, comment_object)|
          messages << <<-MESSAGE.gsub(/^\s*/, '')
          expected not to extract comment in #{line}
          expected: '#{comment_object.value}'
          got: '#{expected}'
          MESSAGE
        end

        @target_comment_list.each do |line, comment|
          messages << <<-MESSAGE.gsub(/^\s*/, '')
          expected not to extract comment in #{line}
          expected: '#{comment}'
          got: not extracted
          MESSAGE
        end

        messages.join("\n")
      end

      def failure_message_for_should_not
        # [todo] - implements here
        # "expected not to render #{expected.inspect}, but did"
      end
    end

    def extract_comment(*args)
      ExtractCommentMatcher.new(self, *args)
    end
  end
end
