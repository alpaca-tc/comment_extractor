require 'strscan'

module CommentExtractor
  class StringScanner < ::StringScanner
    def current_line
      string[0...charpos].count("\n") + 1
    end
  end
end
