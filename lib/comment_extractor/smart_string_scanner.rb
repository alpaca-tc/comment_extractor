require 'strscan'

module CommentExtractor
  module SmartStringScanner
    refine StringScanner do
      def current_line
        string[0...charpos].count("\n") + 1
      end
    end
  end
end
