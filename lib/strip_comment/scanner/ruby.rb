require 'rdoc'

class CommentParser::Scanner::Ruby < CommentParser::Scanner
  filename /\.rb$/
  filetype 'ruby'
  shebang /.*ruby$/

  # [todo] - Uses original implementation for scanning comments
  class Options < Hash
    def tab_width
      2
    end
  end

  def scan
    tokens = RDoc::RubyLex.tokenize(content, Options.new)

    tokens.each do |token|
      if token.is_a?(RDoc::RubyToken::TkCOMMENT)
        self.add_comment(token.line_no, token.value.sub(/^\s*#\s?/, ''))
      end
    end

    self.comments
  end
end
